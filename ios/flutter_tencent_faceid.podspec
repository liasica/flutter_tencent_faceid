#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_tencent_faceid.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_tencent_faceid'
  s.version          = '1.0.0'
  s.summary          = '腾讯云人脸核身 Flutter 插件，支持身份证 OCR 与活体人脸核验'
  s.description      = <<-DESC
  腾讯云人脸核身 Flutter 插件，支持身份证 OCR 与活体人脸核验。
  DESC
  s.homepage         = 'https://github.com/liasica/flutter_tencent_faceid'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'liasica' => 'magicrolan@qq.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'

  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64',
    # 腾讯主 framework 为静态 archive，CocoaPods 默认链接顺序会让其依赖库
    # 先于主 archive 出现。force_load 保证 C++ 实现被纳入插件 framework。
    'OTHER_LDFLAGS' => '$(inherited) -ObjC -force_load "${PODS_XCFRAMEWORKS_BUILD_DIR}/flutter_tencent_faceid/libWbCombined.a" -force_load "${PODS_XCFRAMEWORKS_BUILD_DIR}/flutter_tencent_faceid/libYTCommonLiveness.a"',
  }
  # use_frameworks! 会把腾讯静态 framework 同时传递给宿主目标，因此宿主链接时
  # 也必须强制装载底层实现库，否则最终 App 仍会出现 C++ undefined symbols。
  s.user_target_xcconfig = {
    'OTHER_LDFLAGS' => '$(inherited) -force_load "${PODS_XCFRAMEWORKS_BUILD_DIR}/flutter_tencent_faceid/libWbCombined.a" -force_load "${PODS_XCFRAMEWORKS_BUILD_DIR}/flutter_tencent_faceid/libYTCommonLiveness.a"',
  }
  s.swift_version = '5.9'

  # 递归引入腾讯 SDK 的 XCFramework 与资源
  s.vendored_frameworks = 'Frameworks/**/*.xcframework'
  s.resources = [
    'Frameworks/**/*.bundle',
    'Frameworks/PrivacyInfo.xcprivacy',
  ]

  # 腾讯 SDK 依赖的系统库与框架
  s.libraries = ['c++', 'z']
  s.ios.frameworks = 'UIKit', 'AVFoundation', 'CoreVideo', 'Security', 'SystemConfiguration', 'CoreMedia', 'VideoToolbox', 'CoreTelephony', 'ImageIO', 'Accelerate', 'WebKit', 'MediaPlayer', 'MobileCoreServices', 'Photos', 'AssetsLibrary'
end
