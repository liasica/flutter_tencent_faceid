# flutter_tencent_faceid_example

`flutter_tencent_faceid` 示例工程。运行前请先按根目录 [README](../README.md) 安装 Android 和 iOS 腾讯 SDK。

示例不包含后端地址、访问 Token 或签名密钥。运行后需要粘贴业务后端为单次 OCR 或人脸核验生成的临时 JSON 参数。

## 运行

```shell
flutter pub get
flutter run
```

Android 运行前需要授予相机权限。iOS 需要先在 `ios/` 目录执行 `pod install`，并使用已配置腾讯服务的真机验证。

## 参数

- OCR JSON 需要包含 `appId`、`userId`、`orderNo`、`version`、`nonce` 和 `sign`。
- 人脸核验 JSON 需要包含 `appId`、`faceId`、`licence`、`nonce`、`orderNo`、`sign`、`userId` 和 `version`。

以上参数必须由业务后端为本次请求临时生成。示例会隐藏 OCR 图片的 Base64 正文，只显示长度，避免将完整身份证图片展示或复制到日志中。
