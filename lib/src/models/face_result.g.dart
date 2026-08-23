// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FaceVerifyResult _$FaceVerifyResultFromJson(Map<String, dynamic> json) =>
    _FaceVerifyResult(
      isSuccess: json['isSuccess'] as bool? ?? false,
      sign: json['sign'] as String? ?? '',
      liveRate: json['liveRate'] as String? ?? '',
      similarity: json['similarity'] as String? ?? '',
      error: json['error'] as String?,
      errorDomain: json['errorDomain'] as String?,
      errorCode: json['errorCode'] as String?,
      errorDescription: json['errorDescription'] as String?,
      errorReason: json['errorReason'] as String?,
    );

Map<String, dynamic> _$FaceVerifyResultToJson(_FaceVerifyResult instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'sign': instance.sign,
      'liveRate': instance.liveRate,
      'similarity': instance.similarity,
      'error': instance.error,
      'errorDomain': instance.errorDomain,
      'errorCode': instance.errorCode,
      'errorDescription': instance.errorDescription,
      'errorReason': instance.errorReason,
    };
