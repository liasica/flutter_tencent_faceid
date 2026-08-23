import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_result.freezed.dart';
part 'face_result.g.dart';

/// 活体人脸核验结果
@Freezed(toStringOverride: false)
abstract class FaceVerifyResult with _$FaceVerifyResult {
  const factory FaceVerifyResult({
    /// 人脸核身是否成功
    @Default(false) bool isSuccess,

    /// 签名
    @Default('') String sign,

    /// 活体检测分数
    @Default('') String liveRate,

    /// 人脸比对分数
    @Default('') String similarity,

    /// 人脸核身错误
    String? error,
  }) = _FaceVerifyResult;

  factory FaceVerifyResult.fromJson(Map<String, dynamic> json) =>
      _$FaceVerifyResultFromJson(json);
}
