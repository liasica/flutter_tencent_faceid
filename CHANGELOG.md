## 1.2.1 - 2026-08-27

- Fix duplicate Objective-C class implementations: `YTLivenessRSA`, `YTLivenessAuthManager` and the other Tencent SDK classes ended up in both `flutter_tencent_faceid.framework` and the host executable, so the runtime logged `Class ... is implemented in both ...` and warned about spurious casting failures and mysterious crashes. Under `use_frameworks!` the plugin's dynamic framework already contains those implementations and the host resolves them through dyld, so the host-side `-force_load` in `user_target_xcconfig` was redundant and has been removed. Device builds link unchanged — no undefined symbols — and the Tencent classes now exist exactly once, in the plugin framework.

## 1.2.0 - 2026-08-25

- Support Apple Silicon iOS 26+ simulators: the Podspec no longer excludes `arm64` for simulator builds. The Tencent SDK ships no arm64 simulator slices, so simulator builds now link none of it — framework search paths and linker flags are all scoped to `iphoneos`, `vendored_frameworks` is replaced by explicit per-SDK linking, and the Swift sources fall back to stubs under `#if targetEnvironment(simulator)` where `ocr()` and `verify()` return `null`. Device builds are unchanged.

## 1.1.2 - 2026-08-25

- Fix the Xcode error `Build input files cannot be found: .../XCFrameworkIntermediates/flutter_tencent_faceid/libWbCombined.a, libYTCommonLiveness.a` on host app builds: CocoaPods declares the copy outputs of static-library XCFrameworks as `.framework` instead of `.a`, so Xcode 16's build-system validation rejects `-force_load` paths pointing at `XCFrameworkIntermediates`. The Podspec now force-loads the original slices inside the plugin's `Frameworks` directory via per-SDK (`iphoneos`/`iphonesimulator`) linker flags, and no longer vendors `libWbCombined.xcframework`/`YTCommonLiveness.xcframework` (their auto-generated `-l` flags would link a second copy and produce duplicate symbols together with `-ObjC`).
- Rewrite `README.md` and `CHANGELOG.md` in English for pub.dev; the full Chinese documentation moves to `doc/README.zh-CN.md` and remains the primary reference.
- Rewrite the package description in English and format `bin/package_sdk.dart` with the Dart formatter.

## 1.1.1 - 2026-08-25

- Add automated publishing via GitHub Actions: pushing a `vX.Y.Z` tag publishes to pub.dev through OIDC, after verifying that pubspec, Podspec and Gradle versions match; already-published versions are skipped.
- Add `tool/bump_version.sh` to update the three version declarations in one command.
- Improve the pubspec `description` and add `topics`.
- Clean up the Android build script: remove the unused `buildscript` block and duplicate repository injection, reducing intrusion into the host project.
- Document that the arm64 warning for Apple Silicon iOS 26+ simulators is expected (the Tencent SDK ships no arm64 simulator slices; real devices and releases are unaffected).

## 1.1.0 - 2026-08-24

- Publish to pub.dev; installation switches to the hosted dependency, with Git references kept for tracking unreleased changes.
- Rename the Android AARs to use the Maven group `com.liasica.flutter_tencent_faceid`.
- Support configuring the SDK zip location (URL or local path) with an optional SHA-256 in the app's top-level `pubspec.yaml` section: Android installs during the host build and iOS during `pod install` when the SDK is missing; a clear error is raised when both the configuration and the files are absent.
- Add the SDK packaging command (`dart run flutter_tencent_faceid:package_sdk` for apps, `tool/package_sdk.sh` inside the plugin repository): it locates the original Tencent deliveries by filename pattern, detects versions, extracts and renames artifacts, produces reproducible zips with a delivery manifest and SHA-256 output, and appends or updates the configuration section in the app's `pubspec.yaml` in place; manual installation remains supported.
- Bundle the original Tencent SDK changelogs (`doc/tencent-sdk-changelogs/`, converted to UTF-8).
- Remove the developer Team ID from the example iOS project; signing is managed by the local Xcode.

## 1.0.0 - 2026-08-23

- Rename the plugin, Dart API, Android namespace, iOS Pod and example project to `flutter_tencent_faceid`.
- Simplify the public Dart entry point to `faceid.dart` and `TencentFaceId`; request and result models drop the `Wb` prefix.
- Move platform implementations into `lib/src/`; models are reduced to `ocr_request.dart`, `ocr_result.dart`, `face_request.dart` and `face_result.dart`.
- Switch app installation to referencing the GitHub repository in `pubspec.yaml`, and add the `sdk_path` command to locate the plugin directory of the current Git dependency.
- Upgrade the Android face SDK to `6.6.14` with the shared Normal SDK `5.1.17`.
- Upgrade the Android OCR SDK to `3.6.0`, adding image-return configuration and empty-path protection for crops.
- Upgrade the iOS face SDK to `8.13.2` and the iOS OCR SDK to `5.8.2`.
- Switch iOS to recursive XCFramework and bundle integration, and include the Tencent SDK `PrivacyInfo.xcprivacy`.
- Enable iOS Window Scene support, fixing face verification failing to launch in some scenes.
- Upgrade Flutter, Freezed, JSON generation and lint dependencies.
- Upgrade the example's runtime permission dependency to `permission_handler 12.0.3`.
- Update the Android example's Gradle, Android Gradle Plugin and Kotlin, and require JDK 17 for builds.
- Raise the minimum iOS version of the plugin and example to `13.0`.
- Migrate the iOS example to the UIScene lifecycle and remove leftover framework links from the old plugin.
- Raise the minimum Flutter version to `3.41.0`, matching the UIScene APIs used by the example.
- Fix Android references after Activity re-creation, and return a clear error when no Activity is attached.
- Pass the backend-provided API version through on iOS face verification.
- Remove full OCR/face result logging and the unused face image channel transfer from the native layers, keeping sensitive data out of system logs.
- Limit code generation input to `lib/`, avoiding recursive scans caused by the CocoaPods plugin symlink.
- Install the Tencent SDK locally with enforcement via `.gitignore`, keeping restricted binaries out of the public repository.
- Rewrite the README and example, removing intranet addresses and hardcoded credentials from the example.
- Add the required `optimalDomain` to the basic face verification request, passed through to the Tencent SDK on both platforms.
- Add structured error fields (`errorDomain`, `errorCode`, `errorDescription`, `errorReason`) to the verification result while keeping the legacy `error` field.
- Add unit tests for request and result models.
- Make consumer ProGuard rules AGP 9 compatible; the global `-ignorewarnings` is no longer injected into host apps.
- Unify on `license` across the backend and Dart models, converting to the Tencent SDK's `licence` spelling only at the native channel boundary.

## 0.0.1 - 2024-01-17

- Initial release with ID-card OCR and liveness face verification for Android and iOS.
