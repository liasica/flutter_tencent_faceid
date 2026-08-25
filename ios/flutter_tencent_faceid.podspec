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

# ===== 真机切片枚举 =====
# 腾讯 SDK 只为部分 xcframework 提供 arm64 模拟器切片（多数模拟器切片仍是
# x86_64/i386），而 Apple Silicon 上的 iOS 26+ 模拟器只有 arm64 运行时。
# 若在 podspec 里用 EXCLUDED_ARCHS 排除模拟器 arm64，Flutter 会把同样的
# 排除传染给宿主 Runner，整个 App 就再也无法在 iOS 26 模拟器上运行。
# 因此改为：模拟器构建完全不链接腾讯 SDK，Swift 侧以 targetEnvironment
# (simulator) 走桩实现；下面所有链接配置一律只在 iphoneos 生效。
#
# 同时，CocoaPods 为静态库型 xcframework 生成的拷贝脚本，其输出清单错误地
# 声明为 <名称>.framework（实际拷贝产物是 <名称>.a）。Xcode 16 的构建系统
# 会把 OTHER_LDFLAGS 里按路径引用的文件当作构建输入校验，找不到声明它的
# 产出任务就报 "Build input files cannot be found"。所以这里不走
# vendored_frameworks，而是直接引用 xcframework 内的原始真机切片——这些
# 文件在 pod install 后始终存在于磁盘上
device_slice_for = lambda do |xcframework|
  variant = Dir.children(xcframework).find do |name|
    next false unless File.directory?(File.join(xcframework, name))
    name.start_with?('ios-') && !name.include?('simulator') && !name.include?('maccatalyst')
  end
  raise "flutter_tencent_faceid: #{File.basename(xcframework)} 缺少真机切片" unless variant
  File.join(xcframework, variant)
end

# 真机切片按产物形态分两类：.framework 走 -framework + 搜索路径；裸静态库
# （libWbCombined、YTCommonLiveness）走 force_load，保证其 C++ 实现被完整
# 装载进插件 framework
device_slices = Dir.glob(File.join(frameworks_dir, '**', '*.xcframework')).sort.map(&device_slice_for)
device_framework_dirs = device_slices.select { |dir| !Dir.glob(File.join(dir, '*.framework')).empty? }
device_static_libs = device_slices.flat_map { |dir| Dir.glob(File.join(dir, '*.a')) }

relative_to_frameworks = lambda do |path|
  path.delete_prefix("#{frameworks_dir}/")
end

framework_search_paths = lambda do |base|
  device_framework_dirs.map { |dir| %("#{base}/#{relative_to_frameworks.call(dir)}") }.join(' ')
end

framework_link_flags = device_framework_dirs
                       .flat_map { |dir| Dir.glob(File.join(dir, '*.framework')) }
                       .map { |path| %(-framework "#{File.basename(path, '.framework')}") }
                       .join(' ')

force_load_flags = lambda do |base|
  device_static_libs.map { |path| %(-force_load "#{base}/#{relative_to_frameworks.call(path)}") }.join(' ')
end

# 插件目标内 Frameworks 目录用 PODS_TARGET_SRCROOT 定位；宿主目标没有该
# 变量，走 Flutter 固定生成的 .symlinks 插件软链
pod_frameworks = '${PODS_TARGET_SRCROOT}/Frameworks'
user_frameworks = '${PODS_ROOT}/../.symlinks/plugins/flutter_tencent_faceid/ios/Frameworks'

Pod::Spec.new do |s|
  s.name             = 'flutter_tencent_faceid'
  s.version          = '1.2.0'
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
  # 模拟器不链接任何腾讯 SDK，因此这里只排除 i386，保留 arm64 让插件能在
  # Apple Silicon 的 iOS 26+ 模拟器上构建
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'FRAMEWORK_SEARCH_PATHS[sdk=iphoneos*]' => "$(inherited) #{framework_search_paths.call(pod_frameworks)}",
    # 腾讯主 framework 为静态 archive，CocoaPods 默认链接顺序会让其依赖库
    # 先于主 archive 出现。force_load 保证 C++ 实现被纳入插件 framework。
    'OTHER_LDFLAGS' => '$(inherited) -ObjC',
    'OTHER_LDFLAGS[sdk=iphoneos*]' => "$(inherited) -ObjC #{framework_link_flags} #{force_load_flags.call(pod_frameworks)}",
  }
  # use_frameworks! 下腾讯静态 framework 的实现会随插件 framework 一起链接到
  # 宿主，宿主链接时也必须强制装载底层实现库，否则最终 App 仍会出现 C++
  # undefined symbols。同样只在真机生效。
  s.user_target_xcconfig = {
    'OTHER_LDFLAGS[sdk=iphoneos*]' => "$(inherited) #{force_load_flags.call(user_frameworks)}",
  }
  s.swift_version = '5.9'

  # 腾讯 SDK 的 xcframework 全部由上方 xcconfig 按真机切片手工链接，不交给
  # CocoaPods 的 vendored_frameworks——一是 vendored 无法按 sdk 区分，模拟器
  # 会被强行链上 x86_64 切片；二是其自动生成的 -l/-framework 会把
  # XCFrameworkIntermediates 里的拷贝再链一次，配合 -ObjC 产生 duplicate
  # symbols。资源 bundle 与隐私清单仍照常拷贝
  s.resources = [
    'Frameworks/**/*.bundle',
    'Frameworks/PrivacyInfo.xcprivacy',
  ]

  # 腾讯 SDK 依赖的系统库与框架
  s.libraries = ['c++', 'z']
  s.ios.frameworks = 'UIKit', 'AVFoundation', 'CoreVideo', 'Security', 'SystemConfiguration', 'CoreMedia', 'VideoToolbox', 'CoreTelephony', 'ImageIO', 'Accelerate', 'WebKit', 'MediaPlayer', 'MobileCoreServices', 'Photos', 'AssetsLibrary'
end
