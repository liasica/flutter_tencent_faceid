#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_tencent_faceid.podspec` to validate before publishing.
#
require 'digest'
require 'yaml'

# ===== 腾讯 SDK 自动下载 =====
# ios/Frameworks 缺少腾讯 SDK 时，pod install 解析本文件会从宿主应用
# pubspec.yaml 的自定义段下载 SDK zip 并解压：
# flutter_tencent_faceid:
#   ios_sdk_url: https://example.com/tencent-faceid-sdk-ios-<版本>.zip
#   ios_sdk_sha256: <可选，zip 的 SHA-256>
# zip 布局约定见插件 README「SDK zip 打包约定」
frameworks_dir = File.expand_path('Frameworks', File.dirname(__FILE__))
face_sdk_dir = File.join(frameworks_dir, 'TencentCloudHuiyanSDKFace_framework')
ocr_sdk_dir = File.join(frameworks_dir, 'WBOCRService-framework')

unless Dir.exist?(face_sdk_dir) && Dir.exist?(ocr_sdk_dir)
  sdk_config = {}
  host_root = nil
  if defined?(Pod::Config)
    host_root = File.expand_path('..', Pod::Config.instance.installation_root.to_s)
    host_pubspec = File.join(host_root, 'pubspec.yaml')
    if File.file?(host_pubspec)
      parsed = begin
        YAML.safe_load(File.read(host_pubspec))
      rescue StandardError
        nil
      end
      section = parsed.is_a?(Hash) ? parsed['flutter_tencent_faceid'] : nil
      sdk_config = section if section.is_a?(Hash)
    end
  end

  sdk_source = sdk_config['ios_sdk_url'].to_s.strip
  if sdk_source.empty?
    raise 'flutter_tencent_faceid: ios/Frameworks 缺少腾讯 SDK。' \
          '请在应用 pubspec.yaml 顶层配置 flutter_tencent_faceid.ios_sdk_url，' \
          '或按插件 README 手工安装后重新执行 pod install'
  end

  expected = sdk_config['ios_sdk_sha256'].to_s.strip
  install_zip = lambda do |zip_path|
    unless expected.empty?
      actual = Digest::SHA256.file(zip_path).hexdigest
      unless actual.casecmp?(expected)
        raise "flutter_tencent_faceid: SDK zip 校验失败\n  预期: #{expected}\n  实际: #{actual}"
      end
    end
    system('unzip', '-q', '-o', zip_path, '-d', frameworks_dir) or
      raise 'flutter_tencent_faceid: 解压腾讯 SDK 失败'
  end

  if sdk_source =~ %r{\Ahttps?://}
    require 'open-uri'
    require 'tempfile'
    puts "flutter_tencent_faceid: 下载腾讯 SDK #{sdk_source}"
    Tempfile.create(['tencent-faceid-sdk-ios', '.zip']) do |tmp|
      tmp.binmode
      URI.parse(sdk_source).open('rb', read_timeout: 600) { |remote| IO.copy_stream(remote, tmp) }
      tmp.flush
      install_zip.call(tmp.path)
    end
  else
    # 本地路径：绝对路径原样使用，相对路径以应用根目录为基准
    zip_path = File.expand_path(sdk_source, host_root || Dir.pwd)
    raise "flutter_tencent_faceid: 本地 SDK zip 不存在: #{zip_path}" unless File.file?(zip_path)
    puts "flutter_tencent_faceid: 使用本地腾讯 SDK #{zip_path}"
    install_zip.call(zip_path)
  end

  unless Dir.exist?(face_sdk_dir) && Dir.exist?(ocr_sdk_dir)
    raise 'flutter_tencent_faceid: 解压后仍缺少 SDK 目录，请检查 zip 打包布局'
  end
  puts "flutter_tencent_faceid: 腾讯 SDK 已安装到 #{frameworks_dir}"
end

Pod::Spec.new do |s|
  s.name             = 'flutter_tencent_faceid'
  s.version          = '1.1.1'
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
