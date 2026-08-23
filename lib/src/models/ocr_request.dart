import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_request.freezed.dart';
part 'ocr_request.g.dart';

/// 身份证 OCR 请求
///
/// [appId] 腾讯云控制台申请的 `WBappid`
/// [userId] 用户唯一标识
/// [orderNo] 本次请求的唯一订单号，最长 32 个字符
/// [apiVersion] 参与本次签名的接口版本
/// [nonce] 单次请求的一次性随机字符串
/// [sign] 由服务端生成的单次签名
@Freezed(toStringOverride: false)
abstract class OcrRequest with _$OcrRequest {
  const factory OcrRequest({
    required String appId,
    required String userId,
    required String orderNo,
    @JsonKey(name: 'version') required String apiVersion,
    required String nonce,
    required String sign,
  }) = _OcrRequest;

  factory OcrRequest.fromJson(Map<String, dynamic> json) =>
      _$OcrRequestFromJson(json);
}
