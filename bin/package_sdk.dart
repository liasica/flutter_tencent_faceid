import 'dart:io';
import 'dart:isolate';

/// `dart run flutter_tencent_faceid:package_sdk` 入口：
/// 定位插件目录后透传参数执行 tool/package_sdk.sh，
/// 工作目录保持在应用项目根，供脚本写入应用的 pubspec.yaml
Future<void> main(List<String> args) async {
  final libraryUri = await Isolate.resolvePackageUri(
    Uri.parse('package:flutter_tencent_faceid/faceid.dart'),
  );

  if (libraryUri == null || libraryUri.scheme != 'file') {
    stderr.writeln('无法定位 flutter_tencent_faceid 的本地目录');
    exitCode = 1;
    return;
  }

  final pluginRoot = File.fromUri(libraryUri).parent.parent.path;
  final script = '$pluginRoot/tool/package_sdk.sh';
  if (!File(script).existsSync()) {
    stderr.writeln('未找到打包脚本: $script');
    exitCode = 1;
    return;
  }

  final process = await Process.start(
    'bash',
    [script, ...args],
    mode: ProcessStartMode.inheritStdio,
  );
  exitCode = await process.exitCode;
}
