// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'league_invitation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeagueInvitation {

 String get id; String get leagueId; String get invitedByUserId; String? get invitedUserEmail; String? get invitedUserId;// Set when user accepts
 String get invitationCode; InvitationStatus get status; DateTime get createdAt; DateTime? get expiresAt; DateTime? get acceptedAt; DateTime? get declinedAt;
/// Create a copy of LeagueInvitation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeagueInvitationCopyWith<LeagueInvitation> get copyWith => _$LeagueInvitationCopyWithImpl<LeagueInvitation>(this as LeagueInvitation, _$identity);

  /// Serializes this LeagueInvitation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeagueInvitation&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.invitedByUserId, invitedByUserId) || other.invitedByUserId == invitedByUserId)&&(identical(other.invitedUserEmail, invitedUserEmail) || other.invitedUserEmail == invitedUserEmail)&&(identical(other.invitedUserId, invitedUserId) || other.invitedUserId == invitedUserId)&&(identical(other.invitationCode, invitationCode) || other.invitationCode == invitationCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.acceptedAt, acceptedAt) || other.acceptedAt == acceptedAt)&&(identical(other.declinedAt, declinedAt) || other.declinedAt == declinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,invitedByUserId,invitedUserEmail,invitedUserId,invitationCode,status,createdAt,expiresAt,acceptedAt,declinedAt);

@override
String toString() {
  return 'LeagueInvitation(id: $id, leagueId: $leagueId, invitedByUserId: $invitedByUserId, invitedUserEmail: $invitedUserEmail, invitedUserId: $invitedUserId, invitationCode: $invitationCode, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, acceptedAt: $acceptedAt, declinedAt: $declinedAt)';
}


}

/// @nodoc
abstract mixin class $LeagueInvitationCopyWith<$Res>  {
  factory $LeagueInvitationCopyWith(LeagueInvitation value, $Res Function(LeagueInvitation) _then) = _$LeagueInvitationCopyWithImpl;
@useResult
$Res call({
 String id, String leagueId, String invitedByUserId, String? invitedUserEmail, String? invitedUserId, String invitationCode, InvitationStatus status, DateTime createdAt, DateTime? expiresAt, DateTime? acceptedAt, DateTime? declinedAt
});




}
/// @nodoc
class _$LeagueInvitationCopyWithImpl<$Res>
    implements $LeagueInvitationCopyWith<$Res> {
  _$LeagueInvitationCopyWithImpl(this._self, this._then);

  final LeagueInvitation _self;
  final $Res Function(LeagueInvitation) _then;

/// Create a copy of LeagueInvitation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? leagueId = null,Object? invitedByUserId = null,Object? invitedUserEmail = freezed,Object? invitedUserId = freezed,Object? invitationCode = null,Object? status = null,Object? createdAt = null,Object? expiresAt = freezed,Object? acceptedAt = freezed,Object? declinedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,invitedByUserId: null == invitedByUserId ? _self.invitedByUserId : invitedByUserId // ignore: cast_nullable_to_non_nullable
as String,invitedUserEmail: freezed == invitedUserEmail ? _self.invitedUserEmail : invitedUserEmail // ignore: cast_nullable_to_non_nullable
as String?,invitedUserId: freezed == invitedUserId ? _self.invitedUserId : invitedUserId // ignore: cast_nullable_to_non_nullable
as String?,invitationCode: null == invitationCode ? _self.invitationCode : invitationCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InvitationStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,acceptedAt: freezed == acceptedAt ? _self.acceptedAt : acceptedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,declinedAt: freezed == declinedAt ? _self.declinedAt : declinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LeagueInvitation].
extension LeagueInvitationPatterns on LeagueInvitation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeagueInvitation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeagueInvitation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeagueInvitation value)  $default,){
final _that = this;
switch (_that) {
case _LeagueInvitation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeagueInvitation value)?  $default,){
final _that = this;
switch (_that) {
case _LeagueInvitation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String leagueId,  String invitedByUserId,  String? invitedUserEmail,  String? invitedUserId,  String invitationCode,  InvitationStatus status,  DateTime createdAt,  DateTime? expiresAt,  DateTime? acceptedAt,  DateTime? declinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeagueInvitation() when $default != null:
return $default(_that.id,_that.leagueId,_that.invitedByUserId,_that.invitedUserEmail,_that.invitedUserId,_that.invitationCode,_that.status,_that.createdAt,_that.expiresAt,_that.acceptedAt,_that.declinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String leagueId,  String invitedByUserId,  String? invitedUserEmail,  String? invitedUserId,  String invitationCode,  InvitationStatus status,  DateTime createdAt,  DateTime? expiresAt,  DateTime? acceptedAt,  DateTime? declinedAt)  $default,) {final _that = this;
switch (_that) {
case _LeagueInvitation():
return $default(_that.id,_that.leagueId,_that.invitedByUserId,_that.invitedUserEmail,_that.invitedUserId,_that.invitationCode,_that.status,_that.createdAt,_that.expiresAt,_that.acceptedAt,_that.declinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String leagueId,  String invitedByUserId,  String? invitedUserEmail,  String? invitedUserId,  String invitationCode,  InvitationStatus status,  DateTime createdAt,  DateTime? expiresAt,  DateTime? acceptedAt,  DateTime? declinedAt)?  $default,) {final _that = this;
switch (_that) {
case _LeagueInvitation() when $default != null:
return $default(_that.id,_that.leagueId,_that.invitedByUserId,_that.invitedUserEmail,_that.invitedUserId,_that.invitationCode,_that.status,_that.createdAt,_that.expiresAt,_that.acceptedAt,_that.declinedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeagueInvitation implements LeagueInvitation {
  const _LeagueInvitation({required this.id, required this.leagueId, required this.invitedByUserId, this.invitedUserEmail, this.invitedUserId, required this.invitationCode, required this.status, required this.createdAt, this.expiresAt, this.acceptedAt, this.declinedAt});
  factory _LeagueInvitation.fromJson(Map<String, dynamic> json) => _$LeagueInvitationFromJson(json);

@override final  String id;
@override final  String leagueId;
@override final  String invitedByUserId;
@override final  String? invitedUserEmail;
@override final  String? invitedUserId;
// Set when user accepts
@override final  String invitationCode;
@override final  InvitationStatus status;
@override final  DateTime createdAt;
@override final  DateTime? expiresAt;
@override final  DateTime? acceptedAt;
@override final  DateTime? declinedAt;

/// Create a copy of LeagueInvitation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeagueInvitationCopyWith<_LeagueInvitation> get copyWith => __$LeagueInvitationCopyWithImpl<_LeagueInvitation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeagueInvitationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeagueInvitation&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.invitedByUserId, invitedByUserId) || other.invitedByUserId == invitedByUserId)&&(identical(other.invitedUserEmail, invitedUserEmail) || other.invitedUserEmail == invitedUserEmail)&&(identical(other.invitedUserId, invitedUserId) || other.invitedUserId == invitedUserId)&&(identical(other.invitationCode, invitationCode) || other.invitationCode == invitationCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.acceptedAt, acceptedAt) || other.acceptedAt == acceptedAt)&&(identical(other.declinedAt, declinedAt) || other.declinedAt == declinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,invitedByUserId,invitedUserEmail,invitedUserId,invitationCode,status,createdAt,expiresAt,acceptedAt,declinedAt);

@override
String toString() {
  return 'LeagueInvitation(id: $id, leagueId: $leagueId, invitedByUserId: $invitedByUserId, invitedUserEmail: $invitedUserEmail, invitedUserId: $invitedUserId, invitationCode: $invitationCode, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, acceptedAt: $acceptedAt, declinedAt: $declinedAt)';
}


}

/// @nodoc
abstract mixin class _$LeagueInvitationCopyWith<$Res> implements $LeagueInvitationCopyWith<$Res> {
  factory _$LeagueInvitationCopyWith(_LeagueInvitation value, $Res Function(_LeagueInvitation) _then) = __$LeagueInvitationCopyWithImpl;
@override @useResult
$Res call({
 String id, String leagueId, String invitedByUserId, String? invitedUserEmail, String? invitedUserId, String invitationCode, InvitationStatus status, DateTime createdAt, DateTime? expiresAt, DateTime? acceptedAt, DateTime? declinedAt
});




}
/// @nodoc
class __$LeagueInvitationCopyWithImpl<$Res>
    implements _$LeagueInvitationCopyWith<$Res> {
  __$LeagueInvitationCopyWithImpl(this._self, this._then);

  final _LeagueInvitation _self;
  final $Res Function(_LeagueInvitation) _then;

/// Create a copy of LeagueInvitation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? leagueId = null,Object? invitedByUserId = null,Object? invitedUserEmail = freezed,Object? invitedUserId = freezed,Object? invitationCode = null,Object? status = null,Object? createdAt = null,Object? expiresAt = freezed,Object? acceptedAt = freezed,Object? declinedAt = freezed,}) {
  return _then(_LeagueInvitation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,invitedByUserId: null == invitedByUserId ? _self.invitedByUserId : invitedByUserId // ignore: cast_nullable_to_non_nullable
as String,invitedUserEmail: freezed == invitedUserEmail ? _self.invitedUserEmail : invitedUserEmail // ignore: cast_nullable_to_non_nullable
as String?,invitedUserId: freezed == invitedUserId ? _self.invitedUserId : invitedUserId // ignore: cast_nullable_to_non_nullable
as String?,invitationCode: null == invitationCode ? _self.invitationCode : invitationCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InvitationStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,acceptedAt: freezed == acceptedAt ? _self.acceptedAt : acceptedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,declinedAt: freezed == declinedAt ? _self.declinedAt : declinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
