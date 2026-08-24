// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FaceVerifyRequest _$FaceVerifyRequestFromJson(Map<String, dynamic> json) =>
    _FaceVerifyRequest(
      appId: json['appId'] as String,
      faceId: json['faceId'] as String,
      license: json['license'] as String,
      nonce: json['nonce'] as String,
      optimalDomain: json['optimalDomain'] as String,
      orderNo: json['orderNo'] as String,
      sign: json['sign'] as String,
      userId: json['userId'] as String,
      apiVersion: json['version'] as String,
    );

Map<String, dynamic> _$FaceVerifyRequestToJson(_FaceVerifyRequest instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'faceId': instance.faceId,
      'license': instance.license,
      'nonce': instance.nonce,
      'optimalDomain': instance.optimalDomain,
      'orderNo': instance.orderNo,
      'sign': instance.sign,
      'userId': instance.userId,
      'version': instance.apiVersion,
    };
