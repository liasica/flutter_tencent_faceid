import 'dart:io';
import 'dart:isolate';

Future<void> main() async {
  final libraryUri = await Isolate.resolvePackageUri(
    Uri.parse('package:flutter_tencent_faceid/faceid.dart'),
  );

  if (libraryUri == null || libraryUri.scheme != 'file') {
    stderr.writeln('无法定位 flutter_tencent_faceid 的本地目录');
    exitCode = 1;
    return;
  }

  stdout.writeln(File.fromUri(libraryUri).parent.parent.path);
}
