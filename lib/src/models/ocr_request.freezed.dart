// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcrRequest {

 String get appId; String get userId; String get orderNo;@JsonKey(name: 'version') String get apiVersion; String get nonce; String get sign;
/// Create a copy of OcrRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrRequestCopyWith<OcrRequest> get copyWith => _$OcrRequestCopyWithImpl<OcrRequest>(this as OcrRequest, _$identity);

  /// Serializes this OcrRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrRequest&&(identical(other.appId, appId) || other.appId == appId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.apiVersion, apiVersion) || other.apiVersion == apiVersion)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.sign, sign) || other.sign == sign));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appId,userId,orderNo,apiVersion,nonce,sign);



}

/// @nodoc
abstract mixin class $OcrRequestCopyWith<$Res>  {
  factory $OcrRequestCopyWith(OcrRequest value, $Res Function(OcrRequest) _then) = _$OcrRequestCopyWithImpl;
@useResult
$Res call({
 String appId, String userId, String orderNo,@JsonKey(name: 'version') String apiVersion, String nonce, String sign
});




}
/// @nodoc
class _$OcrRequestCopyWithImpl<$Res>
    implements $OcrRequestCopyWith<$Res> {
  _$OcrRequestCopyWithImpl(this._self, this._then);

  final OcrRequest _self;
  final $Res Function(OcrRequest) _then;

/// Create a copy of OcrRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appId = null,Object? userId = null,Object? orderNo = null,Object? apiVersion = null,Object? nonce = null,Object? sign = null,}) {
  return _then(_self.copyWith(
appId: null == appId ? _self.appId : appId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,orderNo: null == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String,apiVersion: null == apiVersion ? _self.apiVersion : apiVersion // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OcrRequest].
extension OcrRequestPatterns on OcrRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OcrRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OcrRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OcrRequest value)  $default,){
final _that = this;
switch (_that) {
case _OcrRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OcrRequest value)?  $default,){
final _that = this;
switch (_that) {
case _OcrRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String appId,  String userId,  String orderNo, @JsonKey(name: 'version')  String apiVersion,  String nonce,  String sign)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OcrRequest() when $default != null:
return $default(_that.appId,_that.userId,_that.orderNo,_that.apiVersion,_that.nonce,_that.sign);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String appId,  String userId,  String orderNo, @JsonKey(name: 'version')  String apiVersion,  String nonce,  String sign)  $default,) {final _that = this;
switch (_that) {
case _OcrRequest():
return $default(_that.appId,_that.userId,_that.orderNo,_that.apiVersion,_that.nonce,_that.sign);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String appId,  String userId,  String orderNo, @JsonKey(name: 'version')  String apiVersion,  String nonce,  String sign)?  $default,) {final _that = this;
switch (_that) {
case _OcrRequest() when $default != null:
return $default(_that.appId,_that.userId,_that.orderNo,_that.apiVersion,_that.nonce,_that.sign);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OcrRequest implements OcrRequest {
  const _OcrRequest({required this.appId, required this.userId, required this.orderNo, @JsonKey(name: 'version') required this.apiVersion, required this.nonce, required this.sign});
  factory _OcrRequest.fromJson(Map<String, dynamic> json) => _$OcrRequestFromJson(json);

@override final  String appId;
@override final  String userId;
@override final  String orderNo;
@override@JsonKey(name: 'version') final  String apiVersion;
@override final  String nonce;
@override final  String sign;

/// Create a copy of OcrRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OcrRequestCopyWith<_OcrRequest> get copyWith => __$OcrRequestCopyWithImpl<_OcrRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OcrRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OcrRequest&&(identical(other.appId, appId) || other.appId == appId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.apiVersion, apiVersion) || other.apiVersion == apiVersion)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.sign, sign) || other.sign == sign));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appId,userId,orderNo,apiVersion,nonce,sign);



}

/// @nodoc
abstract mixin class _$OcrRequestCopyWith<$Res> implements $OcrRequestCopyWith<$Res> {
  factory _$OcrRequestCopyWith(_OcrRequest value, $Res Function(_OcrRequest) _then) = __$OcrRequestCopyWithImpl;
@override @useResult
$Res call({
 String appId, String userId, String orderNo,@JsonKey(name: 'version') String apiVersion, String nonce, String sign
});




}
/// @nodoc
class __$OcrRequestCopyWithImpl<$Res>
    implements _$OcrRequestCopyWith<$Res> {
  __$OcrRequestCopyWithImpl(this._self, this._then);

  final _OcrRequest _self;
  final $Res Function(_OcrRequest) _then;

/// Create a copy of OcrRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appId = null,Object? userId = null,Object? orderNo = null,Object? apiVersion = null,Object? nonce = null,Object? sign = null,}) {
  return _then(_OcrRequest(
appId: null == appId ? _self.appId : appId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,orderNo: null == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String,apiVersion: null == apiVersion ? _self.apiVersion : apiVersion // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
