import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'models.dart';
import 'platform.dart';

/// 使用 Method Channel 的平台实现
class MethodChannelFaceId extends FaceIdPlatform {
  static const _methodChannelName = 'com.liasica.flutter_tencent_faceid/method';

  /// 与原生平台通信的 Method Channel
  @visibleForTesting
  final methodChannel = const MethodChannel(_methodChannelName);

  @override
  Future<OcrResult?> ocr(OcrRequest request) async {
    final result = await methodChannel.invokeMapMethod<String, dynamic>(
      'ocr',
      request.toJson(),
    );
    return result == null ? null : OcrResult.fromJson(result);
  }

  @override
  Future<FaceVerifyResult?> verify(FaceVerifyRequest request) async {
    final result = await methodChannel.invokeMapMethod<String, dynamic>(
      'face',
      request.toJson(),
    );
    return result == null ? null : FaceVerifyResult.fromJson(result);
  }
}
