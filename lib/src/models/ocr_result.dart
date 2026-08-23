import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_result.freezed.dart';
part 'ocr_result.g.dart';

/// 身份证 OCR 结果
@Freezed(toStringOverride: false)
abstract class OcrResult with _$OcrResult {
  const factory OcrResult({
    /// 身份证号
    @JsonKey(name: 'idcard') String? idCard,

    /// 姓名
    String? name,

    /// 性别
    String? sex,

    /// 民族
    String? nation,

    /// 住址
    String? address,

    /// 出生日期
    @JsonKey(name: 'birth') String? birthDate,

    /// 签发机关
    String? authority,

    /// 有效期限
    String? validDate,

    /// 人像面警告
    String? frontWarning,

    /// 国徽面警告
    String? backWarning,

    /// 人像面清晰度
    String? frontClarity,

    /// 国徽面清晰度
    String? backClarity,

    /// 人像面识别结果码
    String? frontCode,

    /// 人像面识别结果描述
    @JsonKey(name: 'frontMsg') String? frontMessage,

    /// 国徽面识别结果码
    String? backCode,

    /// 国徽面识别结果描述
    @JsonKey(name: 'backMsg') String? backMessage,

    /// 人像面切图
    String? frontCrop,

    /// 国徽面切图
    String? backCrop,
  }) = _OcrResult;

  factory OcrResult.fromJson(Map<String, dynamic> json) =>
      _$OcrResultFromJson(json);
}
