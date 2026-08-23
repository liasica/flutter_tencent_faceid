// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcrResult {

/// 身份证号
@JsonKey(name: 'idcard') String? get idCard;/// 姓名
 String? get name;/// 性别
 String? get sex;/// 民族
 String? get nation;/// 住址
 String? get address;/// 出生日期
@JsonKey(name: 'birth') String? get birthDate;/// 签发机关
 String? get authority;/// 有效期限
 String? get validDate;/// 人像面警告
 String? get frontWarning;/// 国徽面警告
 String? get backWarning;/// 人像面清晰度
 String? get frontClarity;/// 国徽面清晰度
 String? get backClarity;/// 人像面识别结果码
 String? get frontCode;/// 人像面识别结果描述
@JsonKey(name: 'frontMsg') String? get frontMessage;/// 国徽面识别结果码
 String? get backCode;/// 国徽面识别结果描述
@JsonKey(name: 'backMsg') String? get backMessage;/// 人像面切图
 String? get frontCrop;/// 国徽面切图
 String? get backCrop;
/// Create a copy of OcrResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrResultCopyWith<OcrResult> get copyWith => _$OcrResultCopyWithImpl<OcrResult>(this as OcrResult, _$identity);

  /// Serializes this OcrResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrResult&&(identical(other.idCard, idCard) || other.idCard == idCard)&&(identical(other.name, name) || other.name == name)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.nation, nation) || other.nation == nation)&&(identical(other.address, address) || other.address == address)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.authority, authority) || other.authority == authority)&&(identical(other.validDate, validDate) || other.validDate == validDate)&&(identical(other.frontWarning, frontWarning) || other.frontWarning == frontWarning)&&(identical(other.backWarning, backWarning) || other.backWarning == backWarning)&&(identical(other.frontClarity, frontClarity) || other.frontClarity == frontClarity)&&(identical(other.backClarity, backClarity) || other.backClarity == backClarity)&&(identical(other.frontCode, frontCode) || other.frontCode == frontCode)&&(identical(other.frontMessage, frontMessage) || other.frontMessage == frontMessage)&&(identical(other.backCode, backCode) || other.backCode == backCode)&&(identical(other.backMessage, backMessage) || other.backMessage == backMessage)&&(identical(other.frontCrop, frontCrop) || other.frontCrop == frontCrop)&&(identical(other.backCrop, backCrop) || other.backCrop == backCrop));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idCard,name,sex,nation,address,birthDate,authority,validDate,frontWarning,backWarning,frontClarity,backClarity,frontCode,frontMessage,backCode,backMessage,frontCrop,backCrop);



}

/// @nodoc
abstract mixin class $OcrResultCopyWith<$Res>  {
  factory $OcrResultCopyWith(OcrResult value, $Res Function(OcrResult) _then) = _$OcrResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'idcard') String? idCard, String? name, String? sex, String? nation, String? address,@JsonKey(name: 'birth') String? birthDate, String? authority, String? validDate, String? frontWarning, String? backWarning, String? frontClarity, String? backClarity, String? frontCode,@JsonKey(name: 'frontMsg') String? frontMessage, String? backCode,@JsonKey(name: 'backMsg') String? backMessage, String? frontCrop, String? backCrop
});




}
/// @nodoc
class _$OcrResultCopyWithImpl<$Res>
    implements $OcrResultCopyWith<$Res> {
  _$OcrResultCopyWithImpl(this._self, this._then);

  final OcrResult _self;
  final $Res Function(OcrResult) _then;

/// Create a copy of OcrResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idCard = freezed,Object? name = freezed,Object? sex = freezed,Object? nation = freezed,Object? address = freezed,Object? birthDate = freezed,Object? authority = freezed,Object? validDate = freezed,Object? frontWarning = freezed,Object? backWarning = freezed,Object? frontClarity = freezed,Object? backClarity = freezed,Object? frontCode = freezed,Object? frontMessage = freezed,Object? backCode = freezed,Object? backMessage = freezed,Object? frontCrop = freezed,Object? backCrop = freezed,}) {
  return _then(_self.copyWith(
idCard: freezed == idCard ? _self.idCard : idCard // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,sex: freezed == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String?,nation: freezed == nation ? _self.nation : nation // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String?,authority: freezed == authority ? _self.authority : authority // ignore: cast_nullable_to_non_nullable
as String?,validDate: freezed == validDate ? _self.validDate : validDate // ignore: cast_nullable_to_non_nullable
as String?,frontWarning: freezed == frontWarning ? _self.frontWarning : frontWarning // ignore: cast_nullable_to_non_nullable
as String?,backWarning: freezed == backWarning ? _self.backWarning : backWarning // ignore: cast_nullable_to_non_nullable
as String?,frontClarity: freezed == frontClarity ? _self.frontClarity : frontClarity // ignore: cast_nullable_to_non_nullable
as String?,backClarity: freezed == backClarity ? _self.backClarity : backClarity // ignore: cast_nullable_to_non_nullable
as String?,frontCode: freezed == frontCode ? _self.frontCode : frontCode // ignore: cast_nullable_to_non_nullable
as String?,frontMessage: freezed == frontMessage ? _self.frontMessage : frontMessage // ignore: cast_nullable_to_non_nullable
as String?,backCode: freezed == backCode ? _self.backCode : backCode // ignore: cast_nullable_to_non_nullable
as String?,backMessage: freezed == backMessage ? _self.backMessage : backMessage // ignore: cast_nullable_to_non_nullable
as String?,frontCrop: freezed == frontCrop ? _self.frontCrop : frontCrop // ignore: cast_nullable_to_non_nullable
as String?,backCrop: freezed == backCrop ? _self.backCrop : backCrop // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OcrResult].
extension OcrResultPatterns on OcrResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OcrResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OcrResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OcrResult value)  $default,){
final _that = this;
switch (_that) {
case _OcrResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OcrResult value)?  $default,){
final _that = this;
switch (_that) {
case _OcrResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'idcard')  String? idCard,  String? name,  String? sex,  String? nation,  String? address, @JsonKey(name: 'birth')  String? birthDate,  String? authority,  String? validDate,  String? frontWarning,  String? backWarning,  String? frontClarity,  String? backClarity,  String? frontCode, @JsonKey(name: 'frontMsg')  String? frontMessage,  String? backCode, @JsonKey(name: 'backMsg')  String? backMessage,  String? frontCrop,  String? backCrop)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OcrResult() when $default != null:
return $default(_that.idCard,_that.name,_that.sex,_that.nation,_that.address,_that.birthDate,_that.authority,_that.validDate,_that.frontWarning,_that.backWarning,_that.frontClarity,_that.backClarity,_that.frontCode,_that.frontMessage,_that.backCode,_that.backMessage,_that.frontCrop,_that.backCrop);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'idcard')  String? idCard,  String? name,  String? sex,  String? nation,  String? address, @JsonKey(name: 'birth')  String? birthDate,  String? authority,  String? validDate,  String? frontWarning,  String? backWarning,  String? frontClarity,  String? backClarity,  String? frontCode, @JsonKey(name: 'frontMsg')  String? frontMessage,  String? backCode, @JsonKey(name: 'backMsg')  String? backMessage,  String? frontCrop,  String? backCrop)  $default,) {final _that = this;
switch (_that) {
case _OcrResult():
return $default(_that.idCard,_that.name,_that.sex,_that.nation,_that.address,_that.birthDate,_that.authority,_that.validDate,_that.frontWarning,_that.backWarning,_that.frontClarity,_that.backClarity,_that.frontCode,_that.frontMessage,_that.backCode,_that.backMessage,_that.frontCrop,_that.backCrop);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'idcard')  String? idCard,  String? name,  String? sex,  String? nation,  String? address, @JsonKey(name: 'birth')  String? birthDate,  String? authority,  String? validDate,  String? frontWarning,  String? backWarning,  String? frontClarity,  String? backClarity,  String? frontCode, @JsonKey(name: 'frontMsg')  String? frontMessage,  String? backCode, @JsonKey(name: 'backMsg')  String? backMessage,  String? frontCrop,  String? backCrop)?  $default,) {final _that = this;
switch (_that) {
case _OcrResult() when $default != null:
return $default(_that.idCard,_that.name,_that.sex,_that.nation,_that.address,_that.birthDate,_that.authority,_that.validDate,_that.frontWarning,_that.backWarning,_that.frontClarity,_that.backClarity,_that.frontCode,_that.frontMessage,_that.backCode,_that.backMessage,_that.frontCrop,_that.backCrop);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OcrResult implements OcrResult {
  const _OcrResult({@JsonKey(name: 'idcard') this.idCard, this.name, this.sex, this.nation, this.address, @JsonKey(name: 'birth') this.birthDate, this.authority, this.validDate, this.frontWarning, this.backWarning, this.frontClarity, this.backClarity, this.frontCode, @JsonKey(name: 'frontMsg') this.frontMessage, this.backCode, @JsonKey(name: 'backMsg') this.backMessage, this.frontCrop, this.backCrop});
  factory _OcrResult.fromJson(Map<String, dynamic> json) => _$OcrResultFromJson(json);

/// 身份证号
@override@JsonKey(name: 'idcard') final  String? idCard;
/// 姓名
@override final  String? name;
/// 性别
@override final  String? sex;
/// 民族
@override final  String? nation;
/// 住址
@override final  String? address;
/// 出生日期
@override@JsonKey(name: 'birth') final  String? birthDate;
/// 签发机关
@override final  String? authority;
/// 有效期限
@override final  String? validDate;
/// 人像面警告
@override final  String? frontWarning;
/// 国徽面警告
@override final  String? backWarning;
/// 人像面清晰度
@override final  String? frontClarity;
/// 国徽面清晰度
@override final  String? backClarity;
/// 人像面识别结果码
@override final  String? frontCode;
/// 人像面识别结果描述
@override@JsonKey(name: 'frontMsg') final  String? frontMessage;
/// 国徽面识别结果码
@override final  String? backCode;
/// 国徽面识别结果描述
@override@JsonKey(name: 'backMsg') final  String? backMessage;
/// 人像面切图
@override final  String? frontCrop;
/// 国徽面切图
@override final  String? backCrop;

/// Create a copy of OcrResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OcrResultCopyWith<_OcrResult> get copyWith => __$OcrResultCopyWithImpl<_OcrResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OcrResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OcrResult&&(identical(other.idCard, idCard) || other.idCard == idCard)&&(identical(other.name, name) || other.name == name)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.nation, nation) || other.nation == nation)&&(identical(other.address, address) || other.address == address)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.authority, authority) || other.authority == authority)&&(identical(other.validDate, validDate) || other.validDate == validDate)&&(identical(other.frontWarning, frontWarning) || other.frontWarning == frontWarning)&&(identical(other.backWarning, backWarning) || other.backWarning == backWarning)&&(identical(other.frontClarity, frontClarity) || other.frontClarity == frontClarity)&&(identical(other.backClarity, backClarity) || other.backClarity == backClarity)&&(identical(other.frontCode, frontCode) || other.frontCode == frontCode)&&(identical(other.frontMessage, frontMessage) || other.frontMessage == frontMessage)&&(identical(other.backCode, backCode) || other.backCode == backCode)&&(identical(other.backMessage, backMessage) || other.backMessage == backMessage)&&(identical(other.frontCrop, frontCrop) || other.frontCrop == frontCrop)&&(identical(other.backCrop, backCrop) || other.backCrop == backCrop));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idCard,name,sex,nation,address,birthDate,authority,validDate,frontWarning,backWarning,frontClarity,backClarity,frontCode,frontMessage,backCode,backMessage,frontCrop,backCrop);



}

/// @nodoc
abstract mixin class _$OcrResultCopyWith<$Res> implements $OcrResultCopyWith<$Res> {
  factory _$OcrResultCopyWith(_OcrResult value, $Res Function(_OcrResult) _then) = __$OcrResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'idcard') String? idCard, String? name, String? sex, String? nation, String? address,@JsonKey(name: 'birth') String? birthDate, String? authority, String? validDate, String? frontWarning, String? backWarning, String? frontClarity, String? backClarity, String? frontCode,@JsonKey(name: 'frontMsg') String? frontMessage, String? backCode,@JsonKey(name: 'backMsg') String? backMessage, String? frontCrop, String? backCrop
});




}
/// @nodoc
class __$OcrResultCopyWithImpl<$Res>
    implements _$OcrResultCopyWith<$Res> {
  __$OcrResultCopyWithImpl(this._self, this._then);

  final _OcrResult _self;
  final $Res Function(_OcrResult) _then;

/// Create a copy of OcrResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idCard = freezed,Object? name = freezed,Object? sex = freezed,Object? nation = freezed,Object? address = freezed,Object? birthDate = freezed,Object? authority = freezed,Object? validDate = freezed,Object? frontWarning = freezed,Object? backWarning = freezed,Object? frontClarity = freezed,Object? backClarity = freezed,Object? frontCode = freezed,Object? frontMessage = freezed,Object? backCode = freezed,Object? backMessage = freezed,Object? frontCrop = freezed,Object? backCrop = freezed,}) {
  return _then(_OcrResult(
idCard: freezed == idCard ? _self.idCard : idCard // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,sex: freezed == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String?,nation: freezed == nation ? _self.nation : nation // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String?,authority: freezed == authority ? _self.authority : authority // ignore: cast_nullable_to_non_nullable
as String?,validDate: freezed == validDate ? _self.validDate : validDate // ignore: cast_nullable_to_non_nullable
as String?,frontWarning: freezed == frontWarning ? _self.frontWarning : frontWarning // ignore: cast_nullable_to_non_nullable
as String?,backWarning: freezed == backWarning ? _self.backWarning : backWarning // ignore: cast_nullable_to_non_nullable
as String?,frontClarity: freezed == frontClarity ? _self.frontClarity : frontClarity // ignore: cast_nullable_to_non_nullable
as String?,backClarity: freezed == backClarity ? _self.backClarity : backClarity // ignore: cast_nullable_to_non_nullable
as String?,frontCode: freezed == frontCode ? _self.frontCode : frontCode // ignore: cast_nullable_to_non_nullable
as String?,frontMessage: freezed == frontMessage ? _self.frontMessage : frontMessage // ignore: cast_nullable_to_non_nullable
as String?,backCode: freezed == backCode ? _self.backCode : backCode // ignore: cast_nullable_to_non_nullable
as String?,backMessage: freezed == backMessage ? _self.backMessage : backMessage // ignore: cast_nullable_to_non_nullable
as String?,frontCrop: freezed == frontCrop ? _self.frontCrop : frontCrop // ignore: cast_nullable_to_non_nullable
as String?,backCrop: freezed == backCrop ? _self.backCrop : backCrop // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
