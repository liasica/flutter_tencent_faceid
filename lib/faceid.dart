import 'src/models.dart';
import 'src/platform.dart';

export 'src/models.dart';

/// 腾讯云人脸核身插件
class TencentFaceId {
  const TencentFaceId();

  /// 调起身份证 OCR
  Future<OcrResult?> ocr(OcrRequest request) =>
      FaceIdPlatform.instance.ocr(request);

  /// 调起活体人脸核验
  Future<FaceVerifyResult?> verify(FaceVerifyRequest request) =>
      FaceIdPlatform.instance.verify(request);
}
