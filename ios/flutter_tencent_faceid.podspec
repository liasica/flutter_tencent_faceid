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
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64', 'OTHER_LDFLAGS' => '-ObjC' }
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
