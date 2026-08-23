// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FaceVerifyRequest {

 String get appId; String get faceId;@JsonKey(name: 'licence') String get license; String get nonce; String get optimalDomain; String get orderNo; String get sign; String get userId;@JsonKey(name: 'version') String get apiVersion;
/// Create a copy of FaceVerifyRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaceVerifyRequestCopyWith<FaceVerifyRequest> get copyWith => _$FaceVerifyRequestCopyWithImpl<FaceVerifyRequest>(this as FaceVerifyRequest, _$identity);

  /// Serializes this FaceVerifyRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceVerifyRequest&&(identical(other.appId, appId) || other.appId == appId)&&(identical(other.faceId, faceId) || other.faceId == faceId)&&(identical(other.license, license) || other.license == license)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.optimalDomain, optimalDomain) || other.optimalDomain == optimalDomain)&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.apiVersion, apiVersion) || other.apiVersion == apiVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appId,faceId,license,nonce,optimalDomain,orderNo,sign,userId,apiVersion);



}

/// @nodoc
abstract mixin class $FaceVerifyRequestCopyWith<$Res>  {
  factory $FaceVerifyRequestCopyWith(FaceVerifyRequest value, $Res Function(FaceVerifyRequest) _then) = _$FaceVerifyRequestCopyWithImpl;
@useResult
$Res call({
 String appId, String faceId,@JsonKey(name: 'licence') String license, String nonce, String optimalDomain, String orderNo, String sign, String userId,@JsonKey(name: 'version') String apiVersion
});




}
/// @nodoc
class _$FaceVerifyRequestCopyWithImpl<$Res>
    implements $FaceVerifyRequestCopyWith<$Res> {
  _$FaceVerifyRequestCopyWithImpl(this._self, this._then);

  final FaceVerifyRequest _self;
  final $Res Function(FaceVerifyRequest) _then;

/// Create a copy of FaceVerifyRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appId = null,Object? faceId = null,Object? license = null,Object? nonce = null,Object? optimalDomain = null,Object? orderNo = null,Object? sign = null,Object? userId = null,Object? apiVersion = null,}) {
  return _then(_self.copyWith(
appId: null == appId ? _self.appId : appId // ignore: cast_nullable_to_non_nullable
as String,faceId: null == faceId ? _self.faceId : faceId // ignore: cast_nullable_to_non_nullable
as String,license: null == license ? _self.license : license // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,optimalDomain: null == optimalDomain ? _self.optimalDomain : optimalDomain // ignore: cast_nullable_to_non_nullable
as String,orderNo: null == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,apiVersion: null == apiVersion ? _self.apiVersion : apiVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FaceVerifyRequest].
extension FaceVerifyRequestPatterns on FaceVerifyRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaceVerifyRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaceVerifyRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaceVerifyRequest value)  $default,){
final _that = this;
switch (_that) {
case _FaceVerifyRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaceVerifyRequest value)?  $default,){
final _that = this;
switch (_that) {
case _FaceVerifyRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String appId,  String faceId, @JsonKey(name: 'licence')  String license,  String nonce,  String optimalDomain,  String orderNo,  String sign,  String userId, @JsonKey(name: 'version')  String apiVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaceVerifyRequest() when $default != null:
return $default(_that.appId,_that.faceId,_that.license,_that.nonce,_that.optimalDomain,_that.orderNo,_that.sign,_that.userId,_that.apiVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String appId,  String faceId, @JsonKey(name: 'licence')  String license,  String nonce,  String optimalDomain,  String orderNo,  String sign,  String userId, @JsonKey(name: 'version')  String apiVersion)  $default,) {final _that = this;
switch (_that) {
case _FaceVerifyRequest():
return $default(_that.appId,_that.faceId,_that.license,_that.nonce,_that.optimalDomain,_that.orderNo,_that.sign,_that.userId,_that.apiVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String appId,  String faceId, @JsonKey(name: 'licence')  String license,  String nonce,  String optimalDomain,  String orderNo,  String sign,  String userId, @JsonKey(name: 'version')  String apiVersion)?  $default,) {final _that = this;
switch (_that) {
case _FaceVerifyRequest() when $default != null:
return $default(_that.appId,_that.faceId,_that.license,_that.nonce,_that.optimalDomain,_that.orderNo,_that.sign,_that.userId,_that.apiVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FaceVerifyRequest implements FaceVerifyRequest {
  const _FaceVerifyRequest({required this.appId, required this.faceId, @JsonKey(name: 'licence') required this.license, required this.nonce, required this.optimalDomain, required this.orderNo, required this.sign, required this.userId, @JsonKey(name: 'version') required this.apiVersion});
  factory _FaceVerifyRequest.fromJson(Map<String, dynamic> json) => _$FaceVerifyRequestFromJson(json);

@override final  String appId;
@override final  String faceId;
@override@JsonKey(name: 'licence') final  String license;
@override final  String nonce;
@override final  String optimalDomain;
@override final  String orderNo;
@override final  String sign;
@override final  String userId;
@override@JsonKey(name: 'version') final  String apiVersion;

/// Create a copy of FaceVerifyRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaceVerifyRequestCopyWith<_FaceVerifyRequest> get copyWith => __$FaceVerifyRequestCopyWithImpl<_FaceVerifyRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FaceVerifyRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaceVerifyRequest&&(identical(other.appId, appId) || other.appId == appId)&&(identical(other.faceId, faceId) || other.faceId == faceId)&&(identical(other.license, license) || other.license == license)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.optimalDomain, optimalDomain) || other.optimalDomain == optimalDomain)&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.apiVersion, apiVersion) || other.apiVersion == apiVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appId,faceId,license,nonce,optimalDomain,orderNo,sign,userId,apiVersion);



}

/// @nodoc
abstract mixin class _$FaceVerifyRequestCopyWith<$Res> implements $FaceVerifyRequestCopyWith<$Res> {
  factory _$FaceVerifyRequestCopyWith(_FaceVerifyRequest value, $Res Function(_FaceVerifyRequest) _then) = __$FaceVerifyRequestCopyWithImpl;
@override @useResult
$Res call({
 String appId, String faceId,@JsonKey(name: 'licence') String license, String nonce, String optimalDomain, String orderNo, String sign, String userId,@JsonKey(name: 'version') String apiVersion
});




}
/// @nodoc
class __$FaceVerifyRequestCopyWithImpl<$Res>
    implements _$FaceVerifyRequestCopyWith<$Res> {
  __$FaceVerifyRequestCopyWithImpl(this._self, this._then);

  final _FaceVerifyRequest _self;
  final $Res Function(_FaceVerifyRequest) _then;

/// Create a copy of FaceVerifyRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appId = null,Object? faceId = null,Object? license = null,Object? nonce = null,Object? optimalDomain = null,Object? orderNo = null,Object? sign = null,Object? userId = null,Object? apiVersion = null,}) {
  return _then(_FaceVerifyRequest(
appId: null == appId ? _self.appId : appId // ignore: cast_nullable_to_non_nullable
as String,faceId: null == faceId ? _self.faceId : faceId // ignore: cast_nullable_to_non_nullable
as String,license: null == license ? _self.license : license // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,optimalDomain: null == optimalDomain ? _self.optimalDomain : optimalDomain // ignore: cast_nullable_to_non_nullable
as String,orderNo: null == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,apiVersion: null == apiVersion ? _self.apiVersion : apiVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
