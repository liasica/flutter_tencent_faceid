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

## 0.0.1 - 2024-01-17

- 首次提供 Android 与 iOS 身份证 OCR、活体人脸核验能力。
