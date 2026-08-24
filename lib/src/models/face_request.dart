import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_request.freezed.dart';
part 'face_request.g.dart';

/// 活体人脸核验请求
///
/// [appId] 腾讯云控制台申请的 `WBappid`
/// [faceId] 后端上传身份信息后取得的人脸核验标识
/// [license] 腾讯云控制台颁发的 SDK License
/// [nonce] 单次请求的一次性随机字符串
/// [optimalDomain] 后端创建 FaceID 会话时返回的最优接入域名
/// [orderNo] 本次请求的唯一订单号，最长 32 个字符
/// [sign] 由服务端生成的单次签名
/// [userId] 用户唯一标识
/// [apiVersion] 参与本次签名的接口版本
@Freezed(toStringOverride: false)
abstract class FaceVerifyRequest with _$FaceVerifyRequest {
  const factory FaceVerifyRequest({
    required String appId,
    required String faceId,
    required String license,
    required String nonce,
    required String optimalDomain,
    required String orderNo,
    required String sign,
    required String userId,
    @JsonKey(name: 'version') required String apiVersion,
  }) = _FaceVerifyRequest;

  factory FaceVerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$FaceVerifyRequestFromJson(json);
}
