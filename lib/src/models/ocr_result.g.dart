// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OcrResult _$OcrResultFromJson(Map<String, dynamic> json) => _OcrResult(
  idCard: json['idcard'] as String?,
  name: json['name'] as String?,
  sex: json['sex'] as String?,
  nation: json['nation'] as String?,
  address: json['address'] as String?,
  birthDate: json['birth'] as String?,
  authority: json['authority'] as String?,
  validDate: json['validDate'] as String?,
  frontWarning: json['frontWarning'] as String?,
  backWarning: json['backWarning'] as String?,
  frontClarity: json['frontClarity'] as String?,
  backClarity: json['backClarity'] as String?,
  frontCode: json['frontCode'] as String?,
  frontMessage: json['frontMsg'] as String?,
  backCode: json['backCode'] as String?,
  backMessage: json['backMsg'] as String?,
  frontCrop: json['frontCrop'] as String?,
  backCrop: json['backCrop'] as String?,
);

Map<String, dynamic> _$OcrResultToJson(_OcrResult instance) =>
    <String, dynamic>{
      'idcard': instance.idCard,
      'name': instance.name,
      'sex': instance.sex,
      'nation': instance.nation,
      'address': instance.address,
      'birth': instance.birthDate,
      'authority': instance.authority,
      'validDate': instance.validDate,
      'frontWarning': instance.frontWarning,
      'backWarning': instance.backWarning,
      'frontClarity': instance.frontClarity,
      'backClarity': instance.backClarity,
      'frontCode': instance.frontCode,
      'frontMsg': instance.frontMessage,
      'backCode': instance.backCode,
      'backMsg': instance.backMessage,
      'frontCrop': instance.frontCrop,
      'backCrop': instance.backCrop,
    };
