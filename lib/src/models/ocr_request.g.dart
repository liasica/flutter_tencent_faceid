// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OcrRequest _$OcrRequestFromJson(Map<String, dynamic> json) => _OcrRequest(
  appId: json['appId'] as String,
  userId: json['userId'] as String,
  orderNo: json['orderNo'] as String,
  apiVersion: json['version'] as String,
  nonce: json['nonce'] as String,
  sign: json['sign'] as String,
);

Map<String, dynamic> _$OcrRequestToJson(_OcrRequest instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'userId': instance.userId,
      'orderNo': instance.orderNo,
      'version': instance.apiVersion,
      'nonce': instance.nonce,
      'sign': instance.sign,
    };
