// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FaceVerifyResult {

/// 人脸核身是否成功
 bool get isSuccess;/// 签名
 String get sign;/// 活体检测分数
 String get liveRate;/// 人脸比对分数
 String get similarity;/// 人脸核身错误
 String? get error;/// SDK 错误域，用于判断请求是否到达人脸比对服务
 String? get errorDomain;/// SDK 错误码
 String? get errorCode;/// SDK 错误描述
 String? get errorDescription;/// SDK 错误的详细原因
 String? get errorReason;
/// Create a copy of FaceVerifyResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaceVerifyResultCopyWith<FaceVerifyResult> get copyWith => _$FaceVerifyResultCopyWithImpl<FaceVerifyResult>(this as FaceVerifyResult, _$identity);

  /// Serializes this FaceVerifyResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceVerifyResult&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.liveRate, liveRate) || other.liveRate == liveRate)&&(identical(other.similarity, similarity) || other.similarity == similarity)&&(identical(other.error, error) || other.error == error)&&(identical(other.errorDomain, errorDomain) || other.errorDomain == errorDomain)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorDescription, errorDescription) || other.errorDescription == errorDescription)&&(identical(other.errorReason, errorReason) || other.errorReason == errorReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isSuccess,sign,liveRate,similarity,error,errorDomain,errorCode,errorDescription,errorReason);



}

/// @nodoc
abstract mixin class $FaceVerifyResultCopyWith<$Res>  {
  factory $FaceVerifyResultCopyWith(FaceVerifyResult value, $Res Function(FaceVerifyResult) _then) = _$FaceVerifyResultCopyWithImpl;
@useResult
$Res call({
 bool isSuccess, String sign, String liveRate, String similarity, String? error, String? errorDomain, String? errorCode, String? errorDescription, String? errorReason
});




}
/// @nodoc
class _$FaceVerifyResultCopyWithImpl<$Res>
    implements $FaceVerifyResultCopyWith<$Res> {
  _$FaceVerifyResultCopyWithImpl(this._self, this._then);

  final FaceVerifyResult _self;
  final $Res Function(FaceVerifyResult) _then;

/// Create a copy of FaceVerifyResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSuccess = null,Object? sign = null,Object? liveRate = null,Object? similarity = null,Object? error = freezed,Object? errorDomain = freezed,Object? errorCode = freezed,Object? errorDescription = freezed,Object? errorReason = freezed,}) {
  return _then(_self.copyWith(
isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,liveRate: null == liveRate ? _self.liveRate : liveRate // ignore: cast_nullable_to_non_nullable
as String,similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,errorDomain: freezed == errorDomain ? _self.errorDomain : errorDomain // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorDescription: freezed == errorDescription ? _self.errorDescription : errorDescription // ignore: cast_nullable_to_non_nullable
as String?,errorReason: freezed == errorReason ? _self.errorReason : errorReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FaceVerifyResult].
extension FaceVerifyResultPatterns on FaceVerifyResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaceVerifyResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaceVerifyResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaceVerifyResult value)  $default,){
final _that = this;
switch (_that) {
case _FaceVerifyResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaceVerifyResult value)?  $default,){
final _that = this;
switch (_that) {
case _FaceVerifyResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSuccess,  String sign,  String liveRate,  String similarity,  String? error,  String? errorDomain,  String? errorCode,  String? errorDescription,  String? errorReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaceVerifyResult() when $default != null:
return $default(_that.isSuccess,_that.sign,_that.liveRate,_that.similarity,_that.error,_that.errorDomain,_that.errorCode,_that.errorDescription,_that.errorReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSuccess,  String sign,  String liveRate,  String similarity,  String? error,  String? errorDomain,  String? errorCode,  String? errorDescription,  String? errorReason)  $default,) {final _that = this;
switch (_that) {
case _FaceVerifyResult():
return $default(_that.isSuccess,_that.sign,_that.liveRate,_that.similarity,_that.error,_that.errorDomain,_that.errorCode,_that.errorDescription,_that.errorReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSuccess,  String sign,  String liveRate,  String similarity,  String? error,  String? errorDomain,  String? errorCode,  String? errorDescription,  String? errorReason)?  $default,) {final _that = this;
switch (_that) {
case _FaceVerifyResult() when $default != null:
return $default(_that.isSuccess,_that.sign,_that.liveRate,_that.similarity,_that.error,_that.errorDomain,_that.errorCode,_that.errorDescription,_that.errorReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FaceVerifyResult implements FaceVerifyResult {
  const _FaceVerifyResult({this.isSuccess = false, this.sign = '', this.liveRate = '', this.similarity = '', this.error, this.errorDomain, this.errorCode, this.errorDescription, this.errorReason});
  factory _FaceVerifyResult.fromJson(Map<String, dynamic> json) => _$FaceVerifyResultFromJson(json);

/// 人脸核身是否成功
@override@JsonKey() final  bool isSuccess;
/// 签名
@override@JsonKey() final  String sign;
/// 活体检测分数
@override@JsonKey() final  String liveRate;
/// 人脸比对分数
@override@JsonKey() final  String similarity;
/// 人脸核身错误
@override final  String? error;
/// SDK 错误域，用于判断请求是否到达人脸比对服务
@override final  String? errorDomain;
/// SDK 错误码
@override final  String? errorCode;
/// SDK 错误描述
@override final  String? errorDescription;
/// SDK 错误的详细原因
@override final  String? errorReason;

/// Create a copy of FaceVerifyResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaceVerifyResultCopyWith<_FaceVerifyResult> get copyWith => __$FaceVerifyResultCopyWithImpl<_FaceVerifyResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FaceVerifyResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaceVerifyResult&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.liveRate, liveRate) || other.liveRate == liveRate)&&(identical(other.similarity, similarity) || other.similarity == similarity)&&(identical(other.error, error) || other.error == error)&&(identical(other.errorDomain, errorDomain) || other.errorDomain == errorDomain)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorDescription, errorDescription) || other.errorDescription == errorDescription)&&(identical(other.errorReason, errorReason) || other.errorReason == errorReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isSuccess,sign,liveRate,similarity,error,errorDomain,errorCode,errorDescription,errorReason);



}

/// @nodoc
abstract mixin class _$FaceVerifyResultCopyWith<$Res> implements $FaceVerifyResultCopyWith<$Res> {
  factory _$FaceVerifyResultCopyWith(_FaceVerifyResult value, $Res Function(_FaceVerifyResult) _then) = __$FaceVerifyResultCopyWithImpl;
@override @useResult
$Res call({
 bool isSuccess, String sign, String liveRate, String similarity, String? error, String? errorDomain, String? errorCode, String? errorDescription, String? errorReason
});




}
/// @nodoc
class __$FaceVerifyResultCopyWithImpl<$Res>
    implements _$FaceVerifyResultCopyWith<$Res> {
  __$FaceVerifyResultCopyWithImpl(this._self, this._then);

  final _FaceVerifyResult _self;
  final $Res Function(_FaceVerifyResult) _then;

/// Create a copy of FaceVerifyResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSuccess = null,Object? sign = null,Object? liveRate = null,Object? similarity = null,Object? error = freezed,Object? errorDomain = freezed,Object? errorCode = freezed,Object? errorDescription = freezed,Object? errorReason = freezed,}) {
  return _then(_FaceVerifyResult(
isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,liveRate: null == liveRate ? _self.liveRate : liveRate // ignore: cast_nullable_to_non_nullable
as String,similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,errorDomain: freezed == errorDomain ? _self.errorDomain : errorDomain // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorDescription: freezed == errorDescription ? _self.errorDescription : errorDescription // ignore: cast_nullable_to_non_nullable
as String?,errorReason: freezed == errorReason ? _self.errorReason : errorReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
