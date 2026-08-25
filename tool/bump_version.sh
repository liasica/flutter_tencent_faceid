#!/bin/bash
#
# 同步更新插件三处版本号（pubspec.yaml、iOS Podspec、android/build.gradle）。
#
# 用法: tool/bump_version.sh <新版本>
# 例如: tool/bump_version.sh 1.2.0
#
# 之后手动补充 CHANGELOG.md 与 README 的版本表、更新记录，提交并打 tag：
#   git tag v<新版本> && git push origin master v<新版本>
set -euo pipefail

[ $# -eq 1 ] || { echo '用法: tool/bump_version.sh <新版本>' >&2; exit 64; }
NEW=$1
echo "$NEW" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+([+-].+)?$' || { echo "错误: 版本号格式非法: $NEW" >&2; exit 1; }

REPO_ROOT=$(cd "$(dirname "$0")/.." && pwd)
OLD=$(grep '^version:' "$REPO_ROOT/pubspec.yaml" | awk '{print $2}')
[ "$OLD" != "$NEW" ] || { echo "版本已是 ${NEW}，无需更新"; exit 0; }

sed -i '' "s/^version: $OLD\$/version: $NEW/" "$REPO_ROOT/pubspec.yaml"
sed -i '' "s/s.version          = '$OLD'/s.version          = '$NEW'/" "$REPO_ROOT/ios/flutter_tencent_faceid.podspec"
sed -i '' "s/^version '$OLD'\$/version '$NEW'/" "$REPO_ROOT/android/build.gradle"

for f in pubspec.yaml ios/flutter_tencent_faceid.podspec android/build.gradle; do
    grep -qF "$NEW" "$REPO_ROOT/$f" || { echo "错误: $f 未更新成功，请手动检查" >&2; exit 1; }
done

echo "版本已从 $OLD 更新为 ${NEW}："
echo '  pubspec.yaml / ios/flutter_tencent_faceid.podspec / android/build.gradle'
echo '接下来：更新 CHANGELOG.md 与 README（版本表、更新记录），提交后执行'
echo "  git tag v$NEW && git push origin master v$NEW"
