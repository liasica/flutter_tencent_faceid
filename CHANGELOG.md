## 1.1.1 - 2026-08-25

- 增加 GitHub Actions 自动发布：推送 `vX.Y.Z` tag 后经 pub.dev OIDC 认证自动发版，发布前校验 pubspec、Podspec 与 Gradle 三处版本一致，版本已存在时自动跳过。
- 新增 `tool/bump_version.sh`，一条命令同步三处版本号。
- 完善 pubspec 的 `description` 与 `topics`。
- 精简 Android 构建脚本：移除无用的 `buildscript` 块与重复仓库注入，减少对宿主项目的侵入。
- 说明 Apple Silicon iOS 26+ 模拟器的 arm64 提示为预期行为（腾讯 SDK 未提供 arm64 模拟器切片，不影响真机与发布）。

## 1.1.0 - 2026-08-24

- 发布到 pub.dev，安装方式改为 hosted 依赖；Git 引用保留用于跟踪未发布的改动。
- Android AAR 统一使用 Maven group `com.liasica.flutter_tencent_faceid` 重命名。
- 支持在应用 `pubspec.yaml` 顶层配置 SDK zip 的 URL 或本地路径与可选 SHA-256：Android 在宿主构建时、iOS 在 `pod install` 时检测到 SDK 缺失即自动安装，缺配置且缺文件时报错提示。
- 增加 SDK 打包命令（应用侧 `dart run flutter_tencent_faceid:package_sdk`，插件仓库内 `tool/package_sdk.sh`）：从腾讯原始交付件目录自动定位并识别版本、提取重命名、可复现打包，输出交付件清单与产物 SHA-256，并自动在应用 `pubspec.yaml` 中追加或原位更新配置段；手工安装流程保留为备选方式。
- 附带腾讯各 SDK 的完整原始更新日志（`doc/tencent-sdk-changelogs/`，已转 UTF-8）。
- 移除示例 iOS 工程中的开发者 Team ID，签名改由本地 Xcode 自动管理。

## 1.0.0 - 2026-08-23

- 将插件、Dart API、Android namespace、iOS Pod 和示例工程统一重命名为 `flutter_tencent_faceid`。
- Dart 公开入口精简为 `faceid.dart` 和 `TencentFaceId`，请求与结果模型统一移除 `Wb` 前缀。
- 将平台实现移入 `lib/src/`，模型文件精简为 `ocr_request.dart`、`ocr_result.dart`、`face_request.dart` 和 `face_result.dart`。
- 将应用安装方式改为在 `pubspec.yaml` 中直接引用 GitHub 仓库，并增加 `sdk_path` 命令定位当前 Git 依赖对应的插件目录。
- Android 人脸核身 SDK 升级到 `6.6.14`，共用 Normal SDK 升级到 `5.1.17`。
- Android OCR SDK 升级到 `3.6.0`，增加图片返回配置和空路径保护。
- iOS 人脸核身 SDK 升级到 `8.13.2`，iOS OCR SDK 升级到 `5.8.2`。
- iOS 改用递归 XCFramework 和 Bundle 接入，并纳入腾讯 SDK 的 `PrivacyInfo.xcprivacy`。
- 启用 iOS Window Scene 支持，修复部分场景下无法调起人脸核验的问题。
- 升级 Flutter、Freezed、JSON 生成和静态分析依赖。
- 将示例的运行时权限依赖升级到与当前 Flutter 稳定工具链兼容的 `permission_handler 12.0.3`。
- 更新 Android 示例的 Gradle、Android Gradle Plugin 和 Kotlin，并明确使用 JDK 17 构建。
- 将插件与示例的最低 iOS 版本统一更新为 `13.0`。
- 更新 iOS 示例到 UIScene 生命周期，清理旧插件残留的 Framework 链接项。
- 将最低 Flutter 版本更新到 `3.41.0`，与示例使用的 UIScene API 保持一致。
- 修复 Android Activity 重建后的引用更新，并在未附着 Activity 时返回明确错误。
- iOS 人脸核验改为透传后端下发的接口版本。
- 移除原生层完整 OCR、人脸结果日志和未使用的人脸图片通道传输，避免敏感信息进入系统日志。
- 将代码生成输入限定在 `lib/`，避免 CocoaPods 的插件软链导致递归扫描。
- 腾讯 SDK 改为本地安装并由 `.gitignore` 强制忽略，避免向公开仓库分发受限二进制文件。
- 重写 README 和示例，移除示例中的内网地址与硬编码凭据。
- 基础版人脸核身请求增加必填 `optimalDomain`，并在 Android、iOS 原生层透传。
- 人脸核身结果增加错误域、错误码、错误描述和详细原因，同时保留原错误字段。
- 增加请求与结果模型单元测试。
- 移除 consumer ProGuard 中 AGP 9 不允许的全局 `-ignorewarnings` 选项。
- 业务后端和 Dart 模型统一使用 `license`，仅在腾讯原生 SDK 通道边界转换为 `licence`。

## 0.0.1 - 2024-01-17

- 首次提供 Android 与 iOS 身份证 OCR、活体人脸核验能力。
