#!/bin/bash
#
# 从腾讯原始交付件目录自动定位 SDK 压缩包，生成交付件清单（含 SHA-256）
# 并打包本插件使用的 SDK zip。
#
# 交付件按文件名模式自动发现（版本号自动识别），目录层级不限。
# 以腾讯交付目录的典型结构为例，可匹配到：
#   安卓接入/APP调用SDK/安卓人脸/Android-人脸核身-v*.zip
#   安卓接入/APP调用SDK/安卓OCR/Android-OCR-v*.zip
#   IOS接入/iOS人脸/iOS-人脸核身-v*.zip
#   IOS接入/iOS OCR/iOS_OCR_SDK_V*.zip
#
# 产物（打包过程可复现，同一交付件重复打包 SHA-256 不变）：
#   tencent-faceid-sdk-android-<版本>.zip   zip 根下平铺 3 个重命名后的 AAR
#   tencent-faceid-sdk-ios-<版本>.zip       zip 根下为 PrivacyInfo.xcprivacy 与两个 SDK 目录
set -euo pipefail

# ===== 交付件文件名模式（腾讯更改命名规则时才需要调整） =====
ANDROID_FACE_PATTERN='Android-人脸核身-v*.zip'
ANDROID_OCR_PATTERN='Android-OCR-v*.zip'
IOS_FACE_PATTERN='iOS-人脸核身-v*.zip'
IOS_OCR_PATTERN='iOS_OCR_SDK_V*.zip'

fail() {
    echo "错误: $*" >&2
    exit 1
}

usage() {
    cat <<'EOF'
用法: tool/package_sdk.sh <腾讯交付件目录> [-o 输出目录] [-v 版本]
      dart run flutter_tencent_faceid:package_sdk <腾讯交付件目录> [-o 输出目录] [-v 版本]

  <腾讯交付件目录>   腾讯原始交付件所在目录，脚本按文件名模式递归查找
                     Android/iOS 人脸与 OCR 共 4 个原始 zip
  -o 输出目录        不存在时自动创建；相对路径以当前目录为基准。
                     默认 <腾讯交付件目录>/插件打包
  -v 版本            产物文件名中的插件版本号，默认读取插件 pubspec.yaml 的 version

输出交付件清单（原始 zip 及其 SHA-256）与两个产物 zip 的 SHA-256。
当前目录存在应用的 pubspec.yaml 时，自动在其中添加或更新
flutter_tencent_faceid 配置段（新段追加到文件末尾；已有段只改动
android_sdk_url、android_sdk_sha256、ios_sdk_url、ios_sdk_sha256 四行，
URL 使用输出目录相对当前目录的路径）。
EOF
}

SOURCE_DIR=''
OUT_DIR=''
VERSION=''

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help) usage; exit 0 ;;
        -o) [ $# -ge 2 ] || fail '-o 缺少目录参数'; OUT_DIR=$2; shift 2 ;;
        -v) [ $# -ge 2 ] || fail '-v 缺少版本参数'; VERSION=$2; shift 2 ;;
        -*) fail "未知选项: $1" ;;
        *) [ -z "$SOURCE_DIR" ] || fail "多余的参数: $1"; SOURCE_DIR=$1; shift ;;
    esac
done

[ -n "$SOURCE_DIR" ] || { usage; exit 64; }
[ -d "$SOURCE_DIR" ] || fail "交付件目录不存在: $SOURCE_DIR"
SOURCE_DIR=$(cd "$SOURCE_DIR" && pwd)

REPO_ROOT=$(cd "$(dirname "$0")/.." && pwd)
if [ -z "$VERSION" ]; then
    VERSION=$(grep '^version:' "$REPO_ROOT/pubspec.yaml" | awk '{print $2}')
    [ -n "$VERSION" ] || fail '无法从 pubspec.yaml 读取版本，请用 -v 指定'
fi

[ -n "$OUT_DIR" ] || OUT_DIR="$SOURCE_DIR/插件打包"
mkdir -p "$OUT_DIR"
OUT_DIR=$(cd "$OUT_DIR" && pwd)

sha256() {
    shasum -a 256 "$1" | awk '{print $1}'
}

# 从文件名解析 SDK 版本号（取最后一个 v/V 后的数字段）
zip_version() {
    basename "$1" | sed -E 's/^.*[vV]([0-9][0-9.]*[0-9]).*\.zip$/\1/'
}

# 按文件名模式在交付件目录中递归查找，要求恰好一个匹配
locate_zip() {
    local label=$1 pattern=$2 matches count
    matches=$(find "$SOURCE_DIR" -type f -name "$pattern" ! -path "$OUT_DIR/*" | LC_ALL=C sort)
    [ -n "$matches" ] || fail "未找到${label}交付件（模式: ${pattern}），请确认目录"
    count=$(echo "$matches" | wc -l | tr -d ' ')
    if [ "$count" -gt 1 ]; then
        fail "发现多个${label}交付件，请保留唯一版本后重试:
$matches"
    fi
    echo "$matches"
}

# 可复现打包：只收文件、路径排序、-X 剔除 uid/gid 等 extra 字段；
# unzip 已恢复交付件内的原始 mtime，因此重复打包字节一致
pack_zip() {
    local staging=$1 output=$2
    rm -f "$output"
    (cd "$staging" && find . -type f ! -name '.DS_Store' | sed 's|^\./||' | LC_ALL=C sort | zip -X -9 -q "$output" -@)
}

WORK_DIR=$(mktemp -d)
trap 'rm -rf "$WORK_DIR"' EXIT

echo '==> 定位交付件'
android_face=$(locate_zip 'Android 人脸' "$ANDROID_FACE_PATTERN")
android_ocr=$(locate_zip 'Android OCR' "$ANDROID_OCR_PATTERN")
ios_face=$(locate_zip 'iOS 人脸' "$IOS_FACE_PATTERN")
ios_ocr=$(locate_zip 'iOS OCR' "$IOS_OCR_PATTERN")

echo '==> 交付件清单'
manifest() {
    echo "  $1: $(basename "$2")（SDK $(zip_version "$2")）"
    echo "      SHA-256: $(sha256 "$2")"
}
manifest 'Android 人脸' "$android_face"
manifest 'Android OCR' "$android_ocr"
manifest 'iOS 人脸' "$ios_face"
manifest 'iOS OCR' "$ios_ocr"

echo '==> 提取 Android AAR'
AAR_DIR="$WORK_DIR/android"
mkdir -p "$AAR_DIR"
# 人脸包提供 FaceLiveSdk 与较新的 Normal；OCR 包只取 OcrSdk-pro，
# 不使用其自带的旧版 Normal（见 README 注意事项）
unzip -q -j "$android_face" 'sdk/WbCloudFaceLiveSdk-face-v*.aar' 'sdk/WbCloudNormal-noBugly-v*.aar' -d "$AAR_DIR"
unzip -q -j "$android_ocr" '*/app/libs/WbCloudOcrSdk-pro-v*.aar' -d "$AAR_DIR"

# 重命名为 group-artifact-version.aar（构建脚本按首末连字符切分 Maven 坐标）
for aar in "$AAR_DIR"/*.aar; do
    name=$(basename "$aar")
    case "$name" in
        WbCloudFaceLiveSdk-face-v*) artifact='WbCloudFaceLiveSdk' ;;
        WbCloudNormal-noBugly-v*) artifact='WbCloudNormal' ;;
        WbCloudOcrSdk-pro-v*) artifact='WbCloudOcrSdk-pro' ;;
        *) fail "无法识别的 AAR: ${name}，请更新脚本重命名规则" ;;
    esac
    aar_version=$(echo "$name" | sed -E 's/^.*-v([0-9][0-9.]*)-[0-9a-f]+\.aar$/\1/')
    [ "$aar_version" != "$name" ] || fail "无法从 $name 解析版本号"
    mv "$aar" "$AAR_DIR/com.liasica.flutter_tencent_faceid-${artifact}-${aar_version}.aar"
done
count=$(ls "$AAR_DIR" | wc -l | tr -d ' ')
[ "$count" = 3 ] || fail "预期 3 个 AAR，实际提取到 $count 个"
ls "$AAR_DIR" | sed 's/^/  /'

echo '==> 提取 iOS SDK'
IOS_STAGING="$WORK_DIR/ios"
mkdir -p "$IOS_STAGING"
unzip -q "$ios_face" '*/SDK/*' -d "$WORK_DIR/ios-face"
face_sdk=$(find "$WORK_DIR/ios-face" -type d -name 'SDK' | head -1)
[ -n "$face_sdk" ] || fail '人脸交付件中未找到 SDK 目录'
[ -d "$face_sdk/TencentCloudHuiyanSDKFace_framework" ] || fail '人脸交付件缺少 TencentCloudHuiyanSDKFace_framework'
[ -f "$face_sdk/PrivacyInfo.xcprivacy" ] || fail '人脸交付件缺少 PrivacyInfo.xcprivacy'
mv "$face_sdk/TencentCloudHuiyanSDKFace_framework" "$IOS_STAGING/"
mv "$face_sdk/PrivacyInfo.xcprivacy" "$IOS_STAGING/"
unzip -q "$ios_ocr" 'WBOCRService-framework/*' -d "$WORK_DIR/ios-ocr"
[ -d "$WORK_DIR/ios-ocr/WBOCRService-framework" ] || fail 'OCR 交付件中未找到 WBOCRService-framework'
mv "$WORK_DIR/ios-ocr/WBOCRService-framework" "$IOS_STAGING/"
ls "$IOS_STAGING" | sed 's/^/  /'

echo '==> 打包'
ANDROID_OUT="$OUT_DIR/tencent-faceid-sdk-android-$VERSION.zip"
IOS_OUT="$OUT_DIR/tencent-faceid-sdk-ios-$VERSION.zip"
pack_zip "$AAR_DIR" "$ANDROID_OUT"
pack_zip "$IOS_STAGING" "$IOS_OUT"

ANDROID_SHA=$(sha256 "$ANDROID_OUT")
IOS_SHA=$(sha256 "$IOS_OUT")

echo ''
echo '==> 产物'
ls -lh "$ANDROID_OUT" "$IOS_OUT" | awk '{print "  " $5 "\t" $9}'
echo ''
echo '==> SHA-256'
echo "  $ANDROID_SHA  $(basename "$ANDROID_OUT")"
echo "  $IOS_SHA  $(basename "$IOS_OUT")"
echo ''

# 在当前目录的应用 pubspec.yaml 中写入配置段：
# 无该段时整段追加到文件末尾；已有该段时只改动四个配置行，其余内容原样保留
ANDROID_URL=''
IOS_URL=''
resolve_config_urls() {
    local rel
    case "$OUT_DIR" in
        "$PWD") rel='' ;;
        "$PWD"/*) rel="${OUT_DIR#"$PWD"/}/" ;;
        *) rel="$OUT_DIR/" ;;
    esac
    ANDROID_URL="${rel}$(basename "$ANDROID_OUT")"
    IOS_URL="${rel}$(basename "$IOS_OUT")"
}

print_config() {
    cat <<EOF
flutter_tencent_faceid:
  android_sdk_url: $ANDROID_URL
  android_sdk_sha256: $ANDROID_SHA
  ios_sdk_url: $IOS_URL
  ios_sdk_sha256: $IOS_SHA
EOF
}

update_host_pubspec() {
    local pubspec="$PWD/pubspec.yaml" tmp="$WORK_DIR/pubspec.updated"
    resolve_config_urls
    if [ ! -f "$pubspec" ]; then
        echo '==> 当前目录没有 pubspec.yaml，未写入配置；应用 pubspec.yaml 配置示例：'
        print_config
        return
    fi
    if grep -q '^name:[[:space:]]*flutter_tencent_faceid[[:space:]]*$' "$pubspec"; then
        echo '==> 当前目录是插件仓库，未写入配置；应用 pubspec.yaml 配置示例：'
        print_config
        return
    fi
    awk -v aurl="$ANDROID_URL" -v asha="$ANDROID_SHA" -v iurl="$IOS_URL" -v isha="$IOS_SHA" '
        function emit_missing() {
            if (!seen["aurl"]) print "  android_sdk_url: " aurl
            if (!seen["asha"]) print "  android_sdk_sha256: " asha
            if (!seen["iurl"]) print "  ios_sdk_url: " iurl
            if (!seen["isha"]) print "  ios_sdk_sha256: " isha
        }
        /^flutter_tencent_faceid:[ \t]*(#.*)?$/ { in_sec = 1; found = 1; print; next }
        in_sec && /^[^ \t#]/ { emit_missing(); in_sec = 0 }
        in_sec && /^[ \t]+android_sdk_url:/ { print "  android_sdk_url: " aurl; seen["aurl"] = 1; next }
        in_sec && /^[ \t]+android_sdk_sha256:/ { print "  android_sdk_sha256: " asha; seen["asha"] = 1; next }
        in_sec && /^[ \t]+ios_sdk_url:/ { print "  ios_sdk_url: " iurl; seen["iurl"] = 1; next }
        in_sec && /^[ \t]+ios_sdk_sha256:/ { print "  ios_sdk_sha256: " isha; seen["isha"] = 1; next }
        { print }
        END {
            if (in_sec) emit_missing()
            if (!found) {
                print ""
                print "flutter_tencent_faceid:"
                print "  android_sdk_url: " aurl
                print "  android_sdk_sha256: " asha
                print "  ios_sdk_url: " iurl
                print "  ios_sdk_sha256: " isha
            }
        }
    ' "$pubspec" > "$tmp"
    mv "$tmp" "$pubspec"
    echo "==> 已更新 ${pubspec}："
    print_config
}

update_host_pubspec
