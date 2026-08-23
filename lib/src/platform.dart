import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel.dart';
import 'models.dart';

abstract class FaceIdPlatform extends PlatformInterface {
  /// 创建平台接口
  FaceIdPlatform() : super(token: _token);

  static final Object _token = Object();

  static FaceIdPlatform _instance = MethodChannelFaceId();

  /// 当前使用的平台实例
  ///
  /// 默认为 [MethodChannelFaceId]
  static FaceIdPlatform get instance => _instance;

  /// 平台实现注册时需要设置此实例
  static set instance(FaceIdPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<OcrResult?> ocr(OcrRequest request) {
    throw UnimplementedError('ocr() 尚未实现');
  }

  Future<FaceVerifyResult?> verify(FaceVerifyRequest request) {
    throw UnimplementedError('verify() 尚未实现');
  }
}
