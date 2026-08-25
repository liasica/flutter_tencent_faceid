# flutter_tencent_faceid

`flutter_tencent_faceid` 是腾讯云人脸核身 Flutter 插件，封装 Android 和 iOS 的身份证 OCR 与活体人脸核验 SDK。

> 版权与分发限制：腾讯 SDK、模型、Framework、AAR 和资源包不属于本仓库的开源代码，本仓库不包含这些文件。使用者必须通过腾讯云控制台或官方授权渠道取得 SDK，打包为 zip 托管到自有存储后由插件在构建时自动下载安装（推荐），或按本文档手工安装到本地插件目录。

## 功能

- Android 和 iOS 身份证连续 OCR。
- Android 和 iOS 活体人脸核验。
- OCR 结果字段、正反面裁剪图 Base64 数据。
- 人脸核验成功状态、签名、活体分数、相似度和结构化错误信息。
- 本地 AAR、XCFramework 和 Bundle 接入，不向公开仓库提交腾讯 SDK。
- 支持在应用 `pubspec.yaml` 配置 SDK zip 的 URL 或本地路径，构建时自动安装并校验。

## 版本与环境

| 项目 | 当前版本或要求 |
| --- | --- |
| 插件 | `1.1.0` |
| Dart | `>=3.9.0 <4.0.0` |
| Flutter | `>=3.41.0` |
| Android 构建 JDK | `17` |
| Android 示例 Gradle | `8.14.3` |
| Android 示例 Android Gradle Plugin | `8.12.3` |
| Android 示例 Kotlin | `2.2.21` |
| Android 插件模块 | `minSdk 19`，`compileSdk 34` |
| Android 示例 SDK | 随 Flutter SDK；本次验证为 `minSdk 24`、`compileSdk 36` |
| iOS | `13.0` 及以上 |
| Swift | `5.9` |
| Android 人脸核身 | `6.6.14` |
| Android WbCloudNormal | `5.1.17` |
| Android OCR | `3.6.0` |
| iOS 人脸核身 | `8.13.2` |
| iOS OCR | `5.8.2` |

## 安装插件

插件已发布到 [pub.dev](https://pub.dev/packages/flutter_tencent_faceid)，在应用目录执行：

```shell
flutter pub add flutter_tencent_faceid
```

也可以在 `pubspec.yaml` 中直接引用 GitHub 仓库跟踪未发布的改动：

```yaml
dependencies:
  flutter_tencent_faceid:
    git:
      url: https://github.com/liasica/flutter_tencent_faceid.git
      ref: master
```

Git 方式的 `ref` 可以使用分支、Tag 或完整 Commit SHA；生产项目应固定到已验证的版本，避免远端分支变化导致依赖内容漂移。

应用项目应提交 `pubspec.lock`，确保团队和 CI 使用同一个已解析版本。

腾讯 SDK 不随 Git 仓库分发，需要另行安装到 Flutter 下载后的插件目录。推荐使用下文的自动下载安装；手工安装作为备选方式保留。

## 自动下载安装（推荐）

把两个 SDK zip（用 `tool/package_sdk.sh` 从腾讯交付件打包，见「SDK zip 打包」）放到构建机可访问的位置——上传到内网服务器、OSS、私有制品库，或直接放进应用的私有仓库——然后在应用 `pubspec.yaml` 顶层增加自定义段：

```yaml
flutter_tencent_faceid:
  android_sdk_url: https://example.com/sdk/tencent-faceid-sdk-android-1.1.0.zip
  android_sdk_sha256: b2940ba923ffed361ec1be2ddaa6e62da8f06517defd4dd28bf300a9e1ae7505
  ios_sdk_url: https://example.com/sdk/tencent-faceid-sdk-ios-1.1.0.zip
  ios_sdk_sha256: 64f253fa17941810d09db2eadf37608208b9fa17778594c596113e73a9940529
```

`*_sdk_url` 也接受本地路径：`http://` 或 `https://` 开头按 URL 下载，其余一律按 zip 文件路径处理——绝对路径原样使用，相对路径以应用根目录（`pubspec.yaml` 所在目录）为基准。适合把 zip 提交到应用的私有仓库随代码分发。在应用根目录执行 `dart run flutter_tencent_faceid:package_sdk <腾讯交付件目录> -o vendor` 可一步完成打包并自动写入以下配置：

```yaml
flutter_tencent_faceid:
  android_sdk_url: vendor/tencent-faceid-sdk-android-1.1.0.zip
  android_sdk_sha256: b2940ba923ffed361ec1be2ddaa6e62da8f06517defd4dd28bf300a9e1ae7505
  ios_sdk_url: vendor/tencent-faceid-sdk-ios-1.1.0.zip
  ios_sdk_sha256: 64f253fa17941810d09db2eadf37608208b9fa17778594c596113e73a9940529
```

行为说明：

- Android 在宿主 Gradle 构建时检查插件 `android/libs/`：没有任何 AAR 且配置了 `android_sdk_url` 时，下载 zip、解压出全部 AAR 并继续构建；未配置且缺文件时构建报错并提示。
- iOS 在每次 `pod install`（包括 `flutter build ios` 自动触发的）解析插件 Podspec 时检查 `ios/Frameworks/`：缺少 SDK 目录且配置了 `ios_sdk_url` 时，下载 zip 解压安装；未配置且缺文件时 `pod install` 报错并提示。
- `*_sha256` 可选，配置后对 zip（无论下载还是本地）做 SHA-256 校验，不一致即中止；建议始终配置。
- 使用本地路径时 zip 源文件不会被修改或删除；下载模式的临时文件在安装后清理。
- SDK 文件就位后不再重复下载。Git ref 变化或 Pub Cache 被清理后解析到新的插件目录，下一次构建会自动重新安装，无需手工处理。
- `pub get` 本身不会触发安装：Dart pub 没有安装钩子，下载发生在首次构建时。

注意该段是 pub 忽略的自定义配置，必须位于 `pubspec.yaml` 顶层（与 `dependencies` 同级），子键使用两空格缩进、值为纯字符串。Android 端按此格式做轻量解析，不支持锚点、多行字符串等复杂 YAML 写法。

`pub get` 或 `pub cache clean` 后需要定位插件实际目录时（例如手工安装），可使用随包提供的命令：

```shell
dart run flutter_tencent_faceid:sdk_path
```

后文使用 `<PLUGIN_ROOT>` 表示该命令输出的绝对路径。

## SDK zip 打包

从腾讯原始交付件目录一键打包（macOS，需要系统 `zip`、`unzip`）。在应用项目根目录执行随包提供的命令：

```shell
dart run flutter_tencent_faceid:package_sdk <腾讯交付件目录> -o vendor
```

维护插件仓库时也可以直接执行同一脚本：

```shell
tool/package_sdk.sh <腾讯交付件目录>
```

脚本按文件名模式在目录中递归定位 Android/iOS 人脸与 OCR 共 4 个原始压缩包（`Android-人脸核身-v*.zip`、`Android-OCR-v*.zip`、`iOS-人脸核身-v*.zip`、`iOS_OCR_SDK_V*.zip`，版本号自动识别），完成提取、重命名与打包，输出：

- 交付件清单：4 个原始 zip 的文件名、SDK 版本与 SHA-256（用于更新下文「交付件校验」表）。
- 两个产物 zip 及其 SHA-256。

`-o` 指定输出目录（不存在时自动创建，相对路径以当前目录为基准），默认写入 `<腾讯交付件目录>/插件打包/`；`-v` 覆盖产物文件名中的插件版本号。打包过程可复现：同一份交付件重复打包得到相同的 SHA-256。

打包完成后，若当前目录存在应用的 `pubspec.yaml`（插件仓库自身除外），脚本自动写入「自动下载安装」所需的配置段：没有该段时整段追加到文件末尾；已有该段时只改动 `android_sdk_url`、`android_sdk_sha256`、`ios_sdk_url`、`ios_sdk_sha256` 四行，段内其他内容原样保留。URL 写入输出目录相对当前目录的路径（如 `-o vendor` 时为 `vendor/tencent-faceid-sdk-android-<版本>.zip`），改用远程托管时把 URL 换成上传地址即可。

zip 布局约定（与「手工安装」两节的提取与重命名规则一致，zip 内不带多余目录层级）：

- `tencent-faceid-sdk-android-<版本>.zip`：zip 根下直接是 3 个重命名后的 AAR。
- `tencent-faceid-sdk-ios-<版本>.zip`：zip 根下是 `PrivacyInfo.xcprivacy`、`TencentCloudHuiyanSDKFace_framework/`、`WBOCRService-framework/`。

与当前 SDK 版本（Android 人脸 `6.6.14`、OCR `3.6.0`；iOS 人脸 `8.13.2`、OCR `5.8.2`）对应的 zip 校验值：

| zip | 大小 | SHA-256 |
| --- | --- | --- |
| `tencent-faceid-sdk-android-1.1.0.zip` | 约 5.9MB | `b2940ba923ffed361ec1be2ddaa6e62da8f06517defd4dd28bf300a9e1ae7505` |
| `tencent-faceid-sdk-ios-1.1.0.zip` | 约 81MB | `64f253fa17941810d09db2eadf37608208b9fa17778594c596113e73a9940529` |

Android zip 解压时按文件名展平提取全部 `*.aar`；iOS zip 用系统 `unzip` 原样解压到 `ios/Frameworks/`。

## 手工安装腾讯 SDK

不使用自动下载时，可按本章把 SDK 手工安装到插件目录，两种方式的最终文件布局完全一致。本章的提取与重命名规则即打包脚本 `tool/package_sdk.sh` 的实现依据。

### 交付件校验

下表记录当前集成使用的腾讯原始交付件，内容来自 `tool/package_sdk.sh` 输出的交付件清单。SHA-256 用于确认本次集成所用文件；如果腾讯重新打包同版本文件，校验值可能变化，应以官方交付信息为准。

| 平台 | 原始压缩包 | SHA-256 |
| --- | --- | --- |
| Android 人脸 | `Android-人脸核身-v6.6.14.zip` | `2507c1b36c5a89b9b8797e912c98e0b436088c4931f30266c749a6b99bfda2c1` |
| Android OCR | `Android-OCR-v3.6.0.zip` | `e0ea4d4523617d54a3b1621a4607b153fd437628dce2525bb2a035eb89f29949` |
| iOS 人脸 | `iOS-人脸核身-v8.13.2.zip` | `2902f3b633b59e7288cab811f8ff931d08c5bde6695e34a1694a0c6c7340b342` |
| iOS OCR | `iOS_OCR_SDK_V5.8.2.zip` | `b2adca3ffdc709afbd27c89b1479607508f16aba6a007c6e09625f6217bb57f2` |

### Android SDK

在 `<PLUGIN_ROOT>/android/libs/` 中，从腾讯交付件提取并按下表重命名 AAR。

| 来源压缩包 | 包内路径 | 目标文件 |
| --- | --- | --- |
| `Android-人脸核身-v6.6.14.zip` | `sdk/WbCloudFaceLiveSdk-face-v6.6.14-4e2eb256.aar` | `<PLUGIN_ROOT>/android/libs/com.liasica.flutter_tencent_faceid-WbCloudFaceLiveSdk-6.6.14.aar` |
| `Android-人脸核身-v6.6.14.zip` | `sdk/WbCloudNormal-noBugly-v5.1.17-de4bceb.aar` | `<PLUGIN_ROOT>/android/libs/com.liasica.flutter_tencent_faceid-WbCloudNormal-5.1.17.aar` |
| `Android-OCR-v3.6.0.zip` | `kyccloudocrsdkdemo-v3.6.0/app/libs/WbCloudOcrSdk-pro-v3.6.0-3d80a775.aar` | `<PLUGIN_ROOT>/android/libs/com.liasica.flutter_tencent_faceid-WbCloudOcrSdk-pro-3.6.0.aar` |

完成后的目录必须是：

```text
<PLUGIN_ROOT>/android/libs/
|-- .gitkeep
|-- com.liasica.flutter_tencent_faceid-WbCloudFaceLiveSdk-6.6.14.aar
|-- com.liasica.flutter_tencent_faceid-WbCloudNormal-5.1.17.aar
`-- com.liasica.flutter_tencent_faceid-WbCloudOcrSdk-pro-3.6.0.aar
```

注意事项：

- 不要复制 OCR 压缩包中的 `WbCloudNormal 5.1.16`。人脸 `6.6.14` 已携带较新的 `5.1.17`，本插件的人脸与 OCR 共用该版本。
- 不要拆分 AAR 内的 `.so` 文件。人脸 SDK 已包含 `armeabi-v7a` 和 `arm64-v8a` 原生库。
- AAR 目标名称必须符合 `group-artifact-version.aar`。构建脚本使用第一个和最后一个连字符分隔 Maven 坐标，因此 artifact 中可以包含 `-pro`。
- 仓库已同步 `txkyc-face-consumer-proguard-rules.pro` 和 `kyc-cloud-normal-proguard-rules.pro`。以后升级 SDK 时，需要同时对比新交付件中的混淆规则。

本次安装的 AAR 校验值：

| 目标文件 | SHA-256 |
| --- | --- |
| `com.liasica.flutter_tencent_faceid-WbCloudFaceLiveSdk-6.6.14.aar` | `818672681619b50927a19d661935e1b56ed32bc40e2d7caac5a6fa5962a1e5d8` |
| `com.liasica.flutter_tencent_faceid-WbCloudNormal-5.1.17.aar` | `5946e640c981e6a31ae455a490b4bddb63f307618c317832319cd181341c2f6b` |
| `com.liasica.flutter_tencent_faceid-WbCloudOcrSdk-pro-3.6.0.aar` | `4830fd67929c7e7d4a37f94ebad7318d81d52ea9efe8957ab5b8cbc4ac8ba843` |

### iOS SDK

将人脸和 OCR SDK 中的整个目录复制到 `<PLUGIN_ROOT>/ios/Frameworks/`。不要从 Demo 目录拼凑单个 Framework，也不要与旧版平铺 `.framework` 混用。

| 来源压缩包 | 包内来源 | 目标路径 |
| --- | --- | --- |
| `iOS-人脸核身-v8.13.2.zip` | `iOS-人脸核身-8.13.2/SDK/TencentCloudHuiyanSDKFace_framework/` | `<PLUGIN_ROOT>/ios/Frameworks/TencentCloudHuiyanSDKFace_framework/` |
| `iOS-人脸核身-v8.13.2.zip` | `iOS-人脸核身-8.13.2/SDK/PrivacyInfo.xcprivacy` | `<PLUGIN_ROOT>/ios/Frameworks/PrivacyInfo.xcprivacy` |
| `iOS_OCR_SDK_V5.8.2.zip` | `WBOCRService-framework/` | `<PLUGIN_ROOT>/ios/Frameworks/WBOCRService-framework/` |

完成后的关键结构：

```text
<PLUGIN_ROOT>/ios/Frameworks/
|-- .gitkeep
|-- PrivacyInfo.xcprivacy
|-- TencentCloudHuiyanSDKFace_framework/
|   |-- Libs/
|   |   |-- TencentCloudHuiyanSDKFace.xcframework/
|   |   |-- TuringShieldCamRisk.xcframework/
|   |   |-- YTCommonLiveness.xcframework/
|   |   `-- libWbCombined.xcframework/
|   `-- Resources/
|       |-- TencentCloudHuiyanSDKFace.bundle/
|       `-- face-tracker-v003.bundle/
`-- WBOCRService-framework/
    |-- WBOCRService.xcframework/
    `-- WBOCRService/
        |-- Assets/WBOCRService.bundle/
        `-- Libs/
            |-- YTImageRefiner.xcframework/
            `-- tiny_opencv2.xcframework/
```

`PrivacyInfo.xcprivacy` 是人脸 SDK `8.13.2` 交付件的隐私清单，必须按原样携带。它不能代替应用自身的隐私清单、隐私政策和生物识别信息合规说明。

### 确认 SDK 未被 Git 跟踪

插件仓库根目录 `.gitignore` 已忽略 `android/libs/*` 和 `ios/Frameworks/*`，只保留 `.gitkeep`。通过 Git 依赖安装时，这些文件位于 Pub Cache，不会进入应用仓库；维护插件本身时可在插件根目录执行：

```shell
cd "<PLUGIN_ROOT>"
git check-ignore -v android/libs/*.aar
git check-ignore -v ios/Frameworks/PrivacyInfo.xcprivacy
git check-ignore -v ios/Frameworks/TencentCloudHuiyanSDKFace_framework
git check-ignore -v ios/Frameworks/WBOCRService-framework
git status --short
```

前四条命令应显示它们命中根目录 `.gitignore`。`git status --short` 不应出现 AAR、XCFramework、Bundle 或 `PrivacyInfo.xcprivacy`。

## 平台配置

### Android

示例工程使用 JDK 17、Gradle `8.14.3`、Android Gradle Plugin `8.12.3` 和 Kotlin `2.2.21`。构建前先通过 `flutter doctor -v` 确认 Flutter 实际使用的 Java 版本。如果本机默认 JDK 较新，应将 Flutter 固定到 JDK 17：

```shell
flutter config --jdk-dir="<JDK_17_DIRECTORY>"
```

如果不希望修改 Flutter 的全局配置，也可以只为当前命令指定 JDK：

```shell
JAVA_HOME="<JDK_17_DIRECTORY>" flutter build apk --debug
```

不要用 JDK 26 直接运行当前 Gradle `8.14.3` 构建。JDK 版本不匹配时，通常会在业务代码编译前出现 `Unsupported class file major version` 或 Java 版本解析错误。

插件与腾讯 SDK 的 Manifest 合并后，最终应用会纳入以下权限：

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
```

Android 6.0 及以上仍然需要在运行时申请相机权限。请在调用 `ocr` 或 `verify` 前完成授权。

### iOS

应用 `Podfile` 至少需要 iOS 13，并建议按示例使用 Framework 和模块化 Header：

```ruby
platform :ios, '13.0'

target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

本插件当前通过 CocoaPods 接入本地腾讯 SDK，不提供 Swift Package Manager 清单。新版 Flutter 可能提示插件未支持 Swift Package Manager，但当前构建仍会通过 CocoaPods 完成集成；不要删除应用的 `Podfile` 或跳过 `pod install`。

在应用 `Info.plist` 中提供符合实际业务的用途描述：

```xml
<key>NSCameraUsageDescription</key>
<string>身份证 OCR 和人脸核验需要使用相机。</string>
<key>NSMicrophoneUsageDescription</key>
<string>人脸核验录制验证视频时需要使用麦克风。</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>腾讯云人脸核身 SDK 需要访问照片资源。</string>
```

腾讯人脸主库与 OCR 全部库的模拟器切片只包含 `x86_64`（无 `arm64`），插件 Podspec 因此在 iPhone Simulator 下排除 `arm64`。构建时 Flutter 会提示本插件 "do not support arm64 architecture ... for Apple Silicon iOS 26+ simulators"，这是该排除的预期结果：真机构建与发布完全不受影响，只是无法在不再支持 Rosetta 的 iOS 26 及以上模拟器中运行。人脸核验与 OCR 依赖相机，模拟器本来就无法走通业务流程，Apple Silicon Mac 上建议直接用真机验证；确需模拟器联调 UI 时，使用 iOS 26 以下的模拟器 Runtime（`x86_64` 经 Rosetta 运行）。

## 后端参数与安全边界

人脸核身和 OCR 的 `sign`、`nonce`、`orderNo` 等参数应由业务后端按腾讯云规则生成，并在每次调用前下发给 App。

- 不要在 Flutter 代码、配置文件、README 或示例中写入 SIGN ticket、私钥或长期 Token。
- `nonce` 和 `sign` 是单次参数，不应缓存或重复使用。
- `orderNo` 应在业务系统中唯一，且不超过 32 个字符。
- App 只负责将本次临时参数传入 SDK，不应在客户端实现签名密钥管理。
- 请求和结果模型已关闭包含字段值的自动 `toString()`，但仍然不要直接记录模型、身份证字段、图片或完整原生返回值。

OCR 参数：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `appId` | `String` | 腾讯云人脸核身控制台的 `WBappid` |
| `userId` | `String` | 业务侧用户唯一标识 |
| `orderNo` | `String` | 本次 OCR 订单号 |
| `version` | `String` | 腾讯接口版本，按后端签名参数传入 |
| `nonce` | `String` | 本次请求的随机字符串 |
| `sign` | `String` | 后端生成的本次签名 |

人脸核验参数：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `appId` | `String` | 腾讯云人脸核身控制台的 `WBappid` |
| `faceId` | `String` | 后端上传身份信息后获得的 `faceId`；具体要求取决于接入模式 |
| `license` | `String` | 腾讯云控制台颁发的 SDK License |
| `nonce` | `String` | 本次请求的随机字符串 |
| `optimalDomain` | `String` | 后端获取 `faceId` 时返回的最优接入域名，必须原样传给 SDK |
| `orderNo` | `String` | 本次人脸核验订单号 |
| `sign` | `String` | 后端生成的本次签名 |
| `userId` | `String` | 业务侧用户唯一标识 |
| `version` | `String` | 腾讯接口版本，通常为 `1.0.0` |

当前 iOS 原生层会检查上述所有人脸核验字段是否为字符串。即使某一接入模式允许空值，JSON 中也应保留对应 key 并传入空字符串，不要传入 `null`。

## Dart 调用

主入口已导出全部公开模型，只需一个 import：

```dart
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_tencent_faceid/faceid.dart';

final faceId = TencentFaceId();
```

### 身份证 OCR

```dart
Future<OcrResult?> startOcr() async {
  final params = await backend.fetchOcrParams();
  final request = OcrRequest.fromJson(params);
  return faceId.ocr(request);
}
```

后端 JSON 可以继续使用腾讯接口字段；`OcrRequest.fromJson` 会将 `version` 映射为 Dart 属性 `apiVersion`。如果不使用 JSON，也可以通过构造函数直接创建 `OcrRequest`，其中所有字段都是必填项。

`OcrResult` 包含以下主要字段：

- 身份信息：`idCard`、`name`、`sex`、`nation`、`address`、`birthDate`。
- 证件信息：`authority`、`validDate`。
- 识别状态：`frontWarning`、`backWarning`、`frontClarity`、`backClarity`、`frontCode`、`frontMessage`、`backCode`、`backMessage`。
- 裁剪图：`frontCrop`、`backCrop`，为可空 Base64 字符串。

原生返回 JSON 中的 `idcard`、`birth`、`frontMsg` 和 `backMsg` 会分别映射为更符合 Dart 命名习惯的 `idCard`、`birthDate`、`frontMessage` 和 `backMessage`；调用 `toJson()` 时仍会输出腾讯原始 key。

处理裁剪图时必须先判空：

```dart
final frontCrop = result?.frontCrop;
if (frontCrop != null) {
  final bytes = base64Decode(frontCrop);
  // 在业务需要的位置显示或加密存储
}
```

### 活体人脸核验

```dart
Future<FaceVerifyResult?> startFaceVerify() async {
  final params = await backend.fetchFaceVerifyParams();
  final request = FaceVerifyRequest.fromJson(params);
  return faceId.verify(request);
}
```

后端 JSON 和 Dart 模型统一使用 `license`，同时传入创建 `faceId` 时取得的 `optimalDomain`。插件只在 Method Channel 与腾讯原生 SDK 的边界把 `license` 转换为腾讯接口使用的 `licence`；业务后端和 Flutter 调用方不需要感知该历史拼写。

`FaceVerifyResult` 包含：

- `isSuccess`：核验是否成功。
- `sign`：腾讯 SDK 返回签名。
- `liveRate`：活体检测分数。
- `similarity`：人脸比对分数。
- `error`：核验错误描述。
- `errorDomain`：SDK 错误域，可用于判断请求是否到达人脸比对服务。
- `errorCode`：SDK 错误码。
- `errorDescription`：SDK 错误详情。
- `errorReason`：SDK 返回的详细实际原因。

### 取消和错误处理

为了保持与旧版插件的行为一致，部分登录失败、用户取消或未产生识别结果的场景会返回 `null`。iOS 人脸核验的初始化错误可能通过 `PlatformException` 返回。

```dart
final params = await backend.fetchFaceVerifyParams();
final request = FaceVerifyRequest.fromJson(params);

try {
  final result = await faceId.verify(request);
  if (result == null) {
    // 处理取消、登录失败或空结果
    return;
  }
  // 处理核验结果
} on PlatformException catch (error) {
  // 记录 error.code 和 error.message，不要记录身份证图片或完整敏感参数
}
```

Android 返回 `NO_ACTIVITY` 表示插件当前没有附着到可展示页面的 Activity，通常发生在应用切换页面、进入后台或配置变化尚未完成时。应等待当前 Activity 恢复后重新发起调用，不要在后台任务中调起 OCR 或人脸页面。

## 构建与验证

安装 SDK 后，在插件根目录执行：

```shell
flutter clean
flutter pub get
dart run build_runner build
flutter analyze
```

仓库维护请求与结果模型单元测试，覆盖 `optimalDomain` 和结构化错误字段。编译只能覆盖通道类型、原生符号和资源链接，最终业务结果仍必须以 Android、iOS 真机联调为准。

验证 Android 示例：

```shell
cd example
flutter pub get
JAVA_HOME="<JDK_17_DIRECTORY>" flutter build apk --debug
```

验证 iOS Pods 和无签名构建：

```shell
cd example/ios
pod install
cd ..
flutter build ios --debug --no-codesign
```

编译通过只能证明交付件、符号和资源已正确链接。发布前至少需要在 Android 和 iOS 真机分别完成一次 OCR 正反面识别和一次人脸核验。

## 从 `flutter_wb_face` 迁移

`1.0.0` 将插件整体更名，不保留旧插件身份的兼容别名。

| 旧名称 | 新名称 |
| --- | --- |
| `flutter_wb_face` | `flutter_tencent_faceid` |
| `package:flutter_wb_face/flutter_wb_face.dart` | `package:flutter_tencent_faceid/faceid.dart` |
| `FlutterWbFace` | `TencentFaceId` |
| `WbOcrModel` | `OcrRequest` |
| `WbOcrResultModel` | `OcrResult` |
| `WbFaceVerifyModel` | `FaceVerifyRequest` |
| `WbFaceVerifyResultModel` | `FaceVerifyResult` |
| `face(model)` | `verify(request)` |
| `com.liasica.flutter_wb_face/method` | `com.liasica.flutter_tencent_faceid/method` |

平台接口和 Method Channel 实现已移入 `lib/src/`，不再属于公开 API。业务代码只应导入 `faceid.dart`。Dart 公开 API 已移除所有 `Wb` 前缀；原生代码中腾讯 SDK 自带的 `Wb` 类型名及原生方法名 `face` 保持不变。

更名后应执行 `flutter clean`、`flutter pub get`，iOS 应删除旧 Pods 生成结果后重新执行 `pod install`，避免旧 Pod 名称或 Method Channel 缓存残留。

## SDK 升级流程

1. 从腾讯云授权渠道获取新交付件，先阅读对应平台更新日志和内置 Demo。
2. 运行 `tool/package_sdk.sh <新交付件目录>` 重新打包（提取、重命名、Normal 版本取舍由脚本完成）；腾讯更改文件命名或包内布局导致脚本报错时，同步调整脚本内的匹配模式与提取规则。
3. 上传新产物并更新应用 `pubspec.yaml` 中的地址与校验值；插件本地开发目录按新 zip 重新安装。
4. 核对并同步 Android 混淆规则、iOS 系统 Framework 依赖、最低系统版本和模拟器架构，不要混入旧版分拆 Framework。
5. 按脚本输出更新本 README 的 SDK 版本表、交付件校验表、zip 校验表、AAR 校验值、版本日志摘要、`doc/tencent-sdk-changelogs/` 内的原始更新日志与 `CHANGELOG.md`。
6. 重新生成 Dart 代码，执行静态分析，再完成 Android 和 iOS 真机双流程验证。

## 发布插件版本

仓库配置了自动发布：推送 `vX.Y.Z` 形式的 tag 后，GitHub Actions 会校验 tag 与 `pubspec.yaml` 版本一致，然后通过 pub.dev 官方 OIDC 认证自动执行发布，无需在仓库配置任何密钥。

一次性前置配置：在 [pub.dev 包管理页](https://pub.dev/packages/flutter_tencent_faceid/admin) 的 Automated publishing 中启用 GitHub Actions 发布，仓库填 `liasica/flutter_tencent_faceid`，tag 模式保持默认 `v{{version}}`。

发版步骤：

1. 更新 `pubspec.yaml`、iOS Podspec、`android/build.gradle` 中的版本号，同步 `CHANGELOG.md` 与本 README 的版本表、更新记录。
2. 提交后打 tag 并推送：

   ```shell
   git tag v1.2.0 && git push origin master v1.2.0
   ```

3. 在仓库 Actions 页确认 Publish to pub.dev 工作流成功，pub.dev 新版本生效可能需要几分钟。

## SDK 版本日志摘要

以下内容根据本次腾讯交付件内的更新日志提炼，用于记录升级原因和回归重点。各 SDK 的完整原始更新日志（已转为 UTF-8）随仓库存放在 [doc/tencent-sdk-changelogs/](doc/tencent-sdk-changelogs/)，升级 SDK 时同步替换。

### Android 标准人脸

| 版本 | 日期 | 主要变化与回归重点 |
| --- | --- | --- |
| `6.6.14` | 2026-08-07 | 新增多组二级域名兜底节点，改善域名解析稳定性。需要验证弱网、DNS 异常和受限网络。 |
| `6.6.12` | 2026-07-22 | 升级设备指纹能力。升级时应复核隐私告知和风险识别配置。 |
| `6.6.8` | 2026-03-02 | 修复偶发崩溃，优化视频录制逻辑和图像清晰度。 |
| `6.6.6.1` | 2026-01-15 | 优化取图逻辑与图像质量。 |
| `6.6.6` | 2025-12-10 | 修复偶发的语音重复播报。 |

`6.6.14` 应与同交付包的 `WbCloudNormal 5.1.17` 配套使用。

### Android OCR

| 版本 | 日期 | 主要变化与回归重点 |
| --- | --- | --- |
| `3.6.0` | 2025-08-13 | 支持 16 KB 内存页大小适配。需要在对应系统和真机上验证原生库加载。 |
| `3.5.18` | 2025-01-02 | 默认由终端返回图片。需要复核图片回传、保存和销毁策略。 |
| `3.5.8` | 2024-05-24 | 高可用优化，建议回归弱网和服务不可用场景。 |
| `3.4.2` | 2023-11-28 | 适配 Android 14。 |
| `3.4.1` | 2023-11-27 | 身份证识别增加 `frontMsg` 和 `backMsg`，并优化连续识别。 |

OCR `3.6.0` 压缩包内的 Normal 版本为 `5.1.16`。本插件与人脸 SDK 共存时改用 `5.1.17`，每次更新后都必须重新回归 OCR，不能只以编译通过作为兼容证明。

### iOS 标准人脸

| 版本 | 日期 | 主要变化与回归重点 |
| --- | --- | --- |
| `8.13.2` | 2026-08-07 | 新增二级域名兜底节点，增强域名解析稳定性。需要验证弱网和 DNS 异常。 |
| `8.13.0` | 2026-07-16 | 升级设备指纹能力。升级时需要复核隐私告知与设备风险识别合规。 |
| `8.12.0` | 2026-05-27 | 增加多语言支持。 |
| `8.11.2` | 2026-02-06 | 精简 SDK 大小。 |
| `8.11.0` | 2026-01-26 | 优化视频录制逻辑。 |

`8.9.0` 起人脸 SDK 改为 XCFramework 交付。当前版本必须整体保留 `Libs/` 和 `Resources/`，不能与旧版分拆 Framework 混用。

### iOS OCR

| 版本 | 日期 | 主要变化与回归重点 |
| --- | --- | --- |
| `5.8.2` | 2025-11-06 | 修复 Xcode 16 打包中废弃 API 失效问题，并改为 XCFramework 输出。 |
| `5.8.1` | 2025-09-25 | 修复已知问题。 |
| `5.8.0` | 2025-08-01 | 优化偶发崩溃。 |
| `5.7.2` | 2025-02-24 | 适配 iOS 18，优化识别体验，新增电子身份证标识字段。 |
| `5.7.1` | 2024-05-13 | 高可用优化并适配 iOS 17。 |

`5.8.2` 必须同时携带 `WBOCRService.xcframework`、`tiny_opencv2.xcframework`、`YTImageRefiner.xcframework` 和 `WBOCRService.bundle`。

## 插件更新记录

### 1.1.0 - 2026-08-24

- 发布到 pub.dev，安装方式改为 hosted 依赖；Git 引用保留用于跟踪未发布的改动。
- Android AAR 统一使用 Maven group `com.liasica.flutter_tencent_faceid` 重命名。
- 支持在应用 `pubspec.yaml` 顶层配置 SDK zip 的 URL 或本地路径与可选 SHA-256：Android 在宿主构建时、iOS 在 `pod install` 时检测到 SDK 缺失即自动安装，缺配置且缺文件时报错提示。
- 增加 SDK 打包命令（应用侧 `dart run flutter_tencent_faceid:package_sdk`，插件仓库内 `tool/package_sdk.sh`）：从腾讯原始交付件目录自动定位并识别版本、提取重命名、可复现打包，输出交付件清单与产物 SHA-256，并自动在应用 `pubspec.yaml` 中追加或原位更新配置段；手工安装流程保留为备选方式。
- 附带腾讯各 SDK 的完整原始更新日志（`doc/tencent-sdk-changelogs/`，已转 UTF-8）。
- 移除示例 iOS 工程中的开发者 Team ID，签名改由本地 Xcode 自动管理。

### 1.0.0 - 2026-08-23

- 仓库和插件由 `flutter_wb_face` 整体更名为 `flutter_tencent_faceid`。
- Dart 公开入口精简为 `faceid.dart` 和 `TencentFaceId`，请求与结果模型统一改为无 `Wb` 前缀的短名称。
- 将平台实现移入 `lib/src/`，并把模型文件精简为 `ocr_request.dart`、`ocr_result.dart`、`face_request.dart` 和 `face_result.dart`。
- 安装方式改为在应用 `pubspec.yaml` 中直接引用 GitHub 仓库，并增加 `sdk_path` 命令定位当前 Git 依赖对应的插件目录。
- 同步 Android OCR 图片返回配置和裁剪图空路径保护。
- 同步 iOS `useWindowSecene` 配置，修复部分 Window Scene 场景下无法调起人脸核验的问题。
- 更新 Android 人脸 `6.6.14`、Normal `5.1.17`、OCR `3.6.0`。
- 更新 iOS 人脸 `8.13.2`、OCR `5.8.2`，切换到递归 XCFramework 和 Bundle 布局。
- 加入腾讯 SDK 隐私清单，更新混淆规则和系统 Framework 依赖。
- 升级 Flutter、Freezed、JSON 生成和 lint 依赖，重新生成模型代码。
- 将示例的运行时权限依赖升级到与当前 Flutter 稳定工具链兼容的 `permission_handler 12.0.3`。
- 更新 Android 示例构建工具链，并明确使用 JDK 17。
- 将插件和示例的最低 iOS 版本统一更新为 `13.0`。
- 更新 iOS 示例到 UIScene 生命周期，清理旧插件残留的 Framework 链接项。
- 将最低 Flutter 版本更新到 `3.41.0`，与示例使用的 UIScene API 保持一致。
- 修复 Android Activity 重建后的引用更新，并在未附着 Activity 时返回明确错误。
- iOS 人脸核验改为透传后端下发的接口版本。
- 移除原生层完整 OCR、人脸结果日志和未使用的人脸图片通道传输，避免敏感信息进入系统日志。
- 将代码生成输入限定在 `lib/`，避免 CocoaPods 的插件软链导致递归扫描。
- 腾讯 SDK 统一改为本地安装并由 `.gitignore` 强制忽略。
- 重写示例和本文档，移除内网地址与硬编码访问凭据。
- 基础版人脸核身请求新增必填 `optimalDomain`，Android 和 iOS 均原样传入腾讯 SDK。
- 人脸核身结果新增 `errorDomain`、`errorCode`、`errorDescription` 和 `errorReason`，保留旧 `error` 字段兼容现有调用方。
- 新增模型单元测试，覆盖最优域名和结构化错误字段的序列化。
- consumer ProGuard 规则兼容 AGP 9，不再向宿主应用注入全局 `-ignorewarnings`。

### 0.0.1 - 2024-01-17

- 首次提供 Android 与 iOS 身份证 OCR、活体人脸核验能力。

## 常见问题

### Android 提示找不到腾讯 SDK 类

优先检查构建日志中 `flutter_tencent_faceid:` 前缀的下载与报错信息。使用手工安装时，执行 `dart run flutter_tencent_faceid:sdk_path`，检查其输出目录下 `android/libs/` 的 3 个 AAR 是否齐全、文件名与本文档一致。调整后执行 `flutter clean`，避免使用旧的本地 Maven 构建目录。

### Android OCR 或人脸核验登录失败

确认 `nonce`、`sign`、`orderNo`、`version`、`appId` 和 `userId` 来自同一次后端请求且没有被重复使用。同时检查 App 权限、网络状态和腾讯云控制台服务状态。

### iOS 提示 `No such module TencentCloudHuiyanSDKFace` 或 `WBOCRService`

重新执行 `dart run flutter_tencent_faceid:sdk_path`，检查两个 SDK 目录是否位于该命令输出目录的 `ios/Frameworks/`，不是应用工程根目录的同名目录。然后执行 `flutter clean`、`flutter pub get` 和 `pod install`。

### iOS 提示缺少 Bundle 或人脸页面无法调起

确认完整复制人脸 SDK `Resources/` 和 OCR `Assets/`，不要只复制 XCFramework。检查 `TencentCloudHuiyanSDKFace.bundle`、`face-tracker-v003.bundle` 和 `WBOCRService.bundle` 是否存在。

### Apple Silicon 模拟器无法链接，或构建提示不支持 arm64 模拟器

腾讯人脸主库与 OCR `5.8.2` 全部库未提供 `arm64` 模拟器切片，插件 Podspec 在模拟器构建下排除 `arm64`，Flutter 因此提示插件不支持 Apple Silicon 的 iOS 26+ 模拟器。这不影响真机与发布，无需处理；需要模拟器时使用 iOS 26 以下的 Runtime（`x86_64` 经 Rosetta 运行），业务验证直接使用真机。腾讯后续交付带 `arm64` 模拟器切片的版本后，按「SDK 升级流程」更新并移除 Podspec 中的 `EXCLUDED_ARCHS` 排除即可。

### 更新 Git ref 或清理 Pub Cache 后 SDK 再次缺失

Git ref 变化或 Pub Cache 被清理后，Flutter 会解析到新的插件目录。配置了自动下载安装时无需手工处理：Android 在下一次构建、iOS 在下一次 `pod install` 时自动重新下载安装。使用手工安装时，重新执行 `flutter pub get` 和 `dart run flutter_tencent_faceid:sdk_path`，再按本文档把腾讯 SDK 安装到新输出的目录；iOS 随后还需要重新执行 `pod install`。

### SDK 文件出现在 `git status`

立即停止提交，检查根目录 `.gitignore` 中的 `/android/libs/*` 和 `/ios/Frameworks/*`。如果文件曾经被 Git 跟踪，仅补忽略规则不会使其自动移出历史，需要另行进行凭据泄漏与版权风险处理。

## 官方文档

- [腾讯云身份证 OCR SDK 接入](https://cloud.tencent.com/document/product/1007/35830)
- [Android 人脸核身接口调用](https://cloud.tencent.com/document/product/1007/114149)
- [iOS 人脸核身配置流程](https://cloud.tencent.com/document/product/1007/114154)
- [iOS 人脸核身接口调用](https://cloud.tencent.com/document/product/1007/114155)
- [SDK 调用签名](https://cloud.tencent.com/document/product/1007/63358)

## 许可与合规

本仓库代码遵循 [LICENSE](LICENSE)。腾讯 SDK 及其资源的版权、授权和分发条款以腾讯云交付件和服务协议为准，不因本仓库的开源许可而改变。

人脸图像、身份证图像、身份证号、活体结果和人脸比对分数均属于高敏感个人信息或生物识别信息。接入方必须自行完成用户告知与授权、最小必要收集、加密传输与存储、访问控制、保留期限和删除等合规工作。
