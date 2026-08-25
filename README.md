# flutter_tencent_faceid

A Flutter plugin for Tencent Cloud FaceID, wrapping the native Android and iOS SDKs for Chinese ID-card OCR and liveness face verification.

**[中文文档 (Chinese documentation)](doc/README.zh-CN.md)** — the primary, most detailed reference for this package.

> Copyright and distribution: the Tencent SDK binaries (AARs, XCFrameworks, model bundles, privacy manifest) are not part of this repository and are not distributed with this package. Obtain them from the Tencent Cloud console or an authorized channel, then let the plugin install them automatically at build time (recommended) or install them manually.

## Features

- ID-card continuous OCR on Android and iOS.
- Liveness face verification on Android and iOS.
- OCR result fields plus Base64 crops of the front and back sides.
- Verification result with signature, liveness rate, similarity and structured error info.
- Automatic Tencent SDK installation at build time from a URL or local path configured in the app's `pubspec.yaml`, with optional SHA-256 verification.

## Requirements

| Item | Version |
| --- | --- |
| Dart | `>=3.9.0 <4.0.0` |
| Flutter | `>=3.41.0` |
| Android | `minSdk 19`, JDK 17 for builds |
| iOS | `13.0+`, integrated via CocoaPods |
| Tencent SDK (Android) | Face `6.6.14`, Normal `5.1.17`, OCR `3.6.0` |
| Tencent SDK (iOS) | Face `8.13.2`, OCR `5.8.2` |

## Install

```shell
flutter pub add flutter_tencent_faceid
```

## Install the Tencent SDK

The Tencent SDK is not bundled. Package it once, host the two zips anywhere your builds can reach (an internal server, OSS, or the app's private repository), and configure the location in the app's `pubspec.yaml`.

### 1. Package the SDK zips

Run in the app root with the original Tencent delivery directory (macOS, requires system `zip`/`unzip`):

```shell
dart run flutter_tencent_faceid:package_sdk <tencent-delivery-dir> -o vendor
```

The script locates the four original Tencent archives by filename pattern, extracts and renames the artifacts, produces reproducible `tencent-faceid-sdk-android-<version>.zip` and `tencent-faceid-sdk-ios-<version>.zip`, prints their SHA-256, and writes the configuration section below into the app's `pubspec.yaml` automatically (appended at the end when absent; only the four lines are updated when present).

### 2. Configuration

```yaml
# Top-level custom section in the app's pubspec.yaml
flutter_tencent_faceid:
  android_sdk_url: vendor/tencent-faceid-sdk-android-1.1.1.zip
  android_sdk_sha256: <sha256 printed by the packaging command>
  ios_sdk_url: vendor/tencent-faceid-sdk-ios-1.1.1.zip
  ios_sdk_sha256: <sha256 printed by the packaging command>
```

- Values starting with `http://` or `https://` are downloaded; anything else is treated as a zip path — absolute, or relative to the app root.
- Android installs the AARs during the host Gradle build; iOS installs the frameworks during `pod install` (also triggered by `flutter build ios`). Missing configuration with missing SDK files fails the build with a clear message.
- `*_sha256` is optional but recommended; mismatches abort the build.
- After a `pub cache clean` or a dependency update the SDK is re-installed automatically on the next build. `pub get` alone never triggers installation (pub has no install hooks).

Manual installation into the plugin directory is also supported — see the [Chinese documentation](doc/README.zh-CN.md) for the exact file layout, checksums and troubleshooting.

## Platform setup

Android — the merged manifest adds these permissions; request camera permission at runtime before calling the APIs:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
```

iOS — use a Podfile with `platform :ios, '13.0'`, `use_frameworks!` and `use_modular_headers!`, and provide `NSCameraUsageDescription`, `NSMicrophoneUsageDescription` and `NSPhotoLibraryUsageDescription` in `Info.plist`. The Tencent SDK ships no arm64 simulator slices, so the plugin excludes arm64 for simulators: it cannot run on Apple Silicon iOS 26+ simulators (which no longer support Rosetta). Real devices and releases are unaffected — the verification flow needs a camera anyway.

## Usage

All parameters (`sign`, `nonce`, `orderNo`, ...) must be generated per request by your backend following Tencent Cloud rules. Never embed SIGN tickets, private keys or long-lived tokens in the client.

```dart
import 'package:flutter_tencent_faceid/faceid.dart';

final faceId = TencentFaceId();

// ID-card OCR
final ocr = await faceId.ocr(OcrRequest.fromJson(paramsFromBackend));
// ocr?.idCard, ocr?.name, ocr?.frontCrop (Base64), ...

// Liveness face verification
final result = await faceId.verify(FaceVerifyRequest.fromJson(paramsFromBackend));
// result?.isSuccess, result?.liveRate, result?.similarity, result?.errorCode, ...
```

Both methods return `null` when the user cancels or no result is produced; iOS initialization errors surface as `PlatformException`. ID images, ID numbers and verification scores are highly sensitive personal data — handle them according to your compliance requirements and never write them to logs.

## Releasing (maintainers)

Bump the version in all three build files with `tool/bump_version.sh <version>`, update the changelogs, then push a `v<version>` tag — GitHub Actions verifies version consistency and publishes to pub.dev via OIDC.

## License

Code in this repository is licensed under [MIT](LICENSE). The Tencent SDK and its resources remain governed by the Tencent Cloud delivery terms and service agreement.
