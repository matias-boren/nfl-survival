// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'league.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeagueSettings {

 int get maxLosses; bool get allowTeamReuse; bool get autoEliminateOnNoPick;
/// Create a copy of LeagueSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeagueSettingsCopyWith<LeagueSettings> get copyWith => _$LeagueSettingsCopyWithImpl<LeagueSettings>(this as LeagueSettings, _$identity);

  /// Serializes this LeagueSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeagueSettings&&(identical(other.maxLosses, maxLosses) || other.maxLosses == maxLosses)&&(identical(other.allowTeamReuse, allowTeamReuse) || other.allowTeamReuse == allowTeamReuse)&&(identical(other.autoEliminateOnNoPick, autoEliminateOnNoPick) || other.autoEliminateOnNoPick == autoEliminateOnNoPick));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxLosses,allowTeamReuse,autoEliminateOnNoPick);

@override
String toString() {
  return 'LeagueSettings(maxLosses: $maxLosses, allowTeamReuse: $allowTeamReuse, autoEliminateOnNoPick: $autoEliminateOnNoPick)';
}


}

/// @nodoc
abstract mixin class $LeagueSettingsCopyWith<$Res>  {
  factory $LeagueSettingsCopyWith(LeagueSettings value, $Res Function(LeagueSettings) _then) = _$LeagueSettingsCopyWithImpl;
@useResult
$Res call({
 int maxLosses, bool allowTeamReuse, bool autoEliminateOnNoPick
});




}
/// @nodoc
class _$LeagueSettingsCopyWithImpl<$Res>
    implements $LeagueSettingsCopyWith<$Res> {
  _$LeagueSettingsCopyWithImpl(this._self, this._then);

  final LeagueSettings _self;
  final $Res Function(LeagueSettings) _then;

/// Create a copy of LeagueSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxLosses = null,Object? allowTeamReuse = null,Object? autoEliminateOnNoPick = null,}) {
  return _then(_self.copyWith(
maxLosses: null == maxLosses ? _self.maxLosses : maxLosses // ignore: cast_nullable_to_non_nullable
as int,allowTeamReuse: null == allowTeamReuse ? _self.allowTeamReuse : allowTeamReuse // ignore: cast_nullable_to_non_nullable
as bool,autoEliminateOnNoPick: null == autoEliminateOnNoPick ? _self.autoEliminateOnNoPick : autoEliminateOnNoPick // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LeagueSettings].
extension LeagueSettingsPatterns on LeagueSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeagueSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeagueSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeagueSettings value)  $default,){
final _that = this;
switch (_that) {
case _LeagueSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeagueSettings value)?  $default,){
final _that = this;
switch (_that) {
case _LeagueSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxLosses,  bool allowTeamReuse,  bool autoEliminateOnNoPick)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeagueSettings() when $default != null:
return $default(_that.maxLosses,_that.allowTeamReuse,_that.autoEliminateOnNoPick);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxLosses,  bool allowTeamReuse,  bool autoEliminateOnNoPick)  $default,) {final _that = this;
switch (_that) {
case _LeagueSettings():
return $default(_that.maxLosses,_that.allowTeamReuse,_that.autoEliminateOnNoPick);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxLosses,  bool allowTeamReuse,  bool autoEliminateOnNoPick)?  $default,) {final _that = this;
switch (_that) {
case _LeagueSettings() when $default != null:
return $default(_that.maxLosses,_that.allowTeamReuse,_that.autoEliminateOnNoPick);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeagueSettings implements LeagueSettings {
  const _LeagueSettings({required this.maxLosses, required this.allowTeamReuse, required this.autoEliminateOnNoPick});
  factory _LeagueSettings.fromJson(Map<String, dynamic> json) => _$LeagueSettingsFromJson(json);

@override final  int maxLosses;
@override final  bool allowTeamReuse;
@override final  bool autoEliminateOnNoPick;

/// Create a copy of LeagueSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeagueSettingsCopyWith<_LeagueSettings> get copyWith => __$LeagueSettingsCopyWithImpl<_LeagueSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeagueSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeagueSettings&&(identical(other.maxLosses, maxLosses) || other.maxLosses == maxLosses)&&(identical(other.allowTeamReuse, allowTeamReuse) || other.allowTeamReuse == allowTeamReuse)&&(identical(other.autoEliminateOnNoPick, autoEliminateOnNoPick) || other.autoEliminateOnNoPick == autoEliminateOnNoPick));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxLosses,allowTeamReuse,autoEliminateOnNoPick);

@override
String toString() {
  return 'LeagueSettings(maxLosses: $maxLosses, allowTeamReuse: $allowTeamReuse, autoEliminateOnNoPick: $autoEliminateOnNoPick)';
}


}

/// @nodoc
abstract mixin class _$LeagueSettingsCopyWith<$Res> implements $LeagueSettingsCopyWith<$Res> {
  factory _$LeagueSettingsCopyWith(_LeagueSettings value, $Res Function(_LeagueSettings) _then) = __$LeagueSettingsCopyWithImpl;
@override @useResult
$Res call({
 int maxLosses, bool allowTeamReuse, bool autoEliminateOnNoPick
});




}
/// @nodoc
class __$LeagueSettingsCopyWithImpl<$Res>
    implements _$LeagueSettingsCopyWith<$Res> {
  __$LeagueSettingsCopyWithImpl(this._self, this._then);

  final _LeagueSettings _self;
  final $Res Function(_LeagueSettings) _then;

/// Create a copy of LeagueSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxLosses = null,Object? allowTeamReuse = null,Object? autoEliminateOnNoPick = null,}) {
  return _then(_LeagueSettings(
maxLosses: null == maxLosses ? _self.maxLosses : maxLosses // ignore: cast_nullable_to_non_nullable
as int,allowTeamReuse: null == allowTeamReuse ? _self.allowTeamReuse : allowTeamReuse // ignore: cast_nullable_to_non_nullable
as bool,autoEliminateOnNoPick: null == autoEliminateOnNoPick ? _self.autoEliminateOnNoPick : autoEliminateOnNoPick // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$LeagueMember {

 String get leagueId; String get userId; int get losses; String get joinedAt;
/// Create a copy of LeagueMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeagueMemberCopyWith<LeagueMember> get copyWith => _$LeagueMemberCopyWithImpl<LeagueMember>(this as LeagueMember, _$identity);

  /// Serializes this LeagueMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeagueMember&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leagueId,userId,losses,joinedAt);

@override
String toString() {
  return 'LeagueMember(leagueId: $leagueId, userId: $userId, losses: $losses, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class $LeagueMemberCopyWith<$Res>  {
  factory $LeagueMemberCopyWith(LeagueMember value, $Res Function(LeagueMember) _then) = _$LeagueMemberCopyWithImpl;
@useResult
$Res call({
 String leagueId, String userId, int losses, String joinedAt
});




}
/// @nodoc
class _$LeagueMemberCopyWithImpl<$Res>
    implements $LeagueMemberCopyWith<$Res> {
  _$LeagueMemberCopyWithImpl(this._self, this._then);

  final LeagueMember _self;
  final $Res Function(LeagueMember) _then;

/// Create a copy of LeagueMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leagueId = null,Object? userId = null,Object? losses = null,Object? joinedAt = null,}) {
  return _then(_self.copyWith(
leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LeagueMember].
extension LeagueMemberPatterns on LeagueMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeagueMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeagueMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeagueMember value)  $default,){
final _that = this;
switch (_that) {
case _LeagueMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeagueMember value)?  $default,){
final _that = this;
switch (_that) {
case _LeagueMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String leagueId,  String userId,  int losses,  String joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeagueMember() when $default != null:
return $default(_that.leagueId,_that.userId,_that.losses,_that.joinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String leagueId,  String userId,  int losses,  String joinedAt)  $default,) {final _that = this;
switch (_that) {
case _LeagueMember():
return $default(_that.leagueId,_that.userId,_that.losses,_that.joinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String leagueId,  String userId,  int losses,  String joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _LeagueMember() when $default != null:
return $default(_that.leagueId,_that.userId,_that.losses,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeagueMember implements LeagueMember {
  const _LeagueMember({required this.leagueId, required this.userId, required this.losses, required this.joinedAt});
  factory _LeagueMember.fromJson(Map<String, dynamic> json) => _$LeagueMemberFromJson(json);

@override final  String leagueId;
@override final  String userId;
@override final  int losses;
@override final  String joinedAt;

/// Create a copy of LeagueMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeagueMemberCopyWith<_LeagueMember> get copyWith => __$LeagueMemberCopyWithImpl<_LeagueMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeagueMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeagueMember&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leagueId,userId,losses,joinedAt);

@override
String toString() {
  return 'LeagueMember(leagueId: $leagueId, userId: $userId, losses: $losses, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$LeagueMemberCopyWith<$Res> implements $LeagueMemberCopyWith<$Res> {
  factory _$LeagueMemberCopyWith(_LeagueMember value, $Res Function(_LeagueMember) _then) = __$LeagueMemberCopyWithImpl;
@override @useResult
$Res call({
 String leagueId, String userId, int losses, String joinedAt
});




}
/// @nodoc
class __$LeagueMemberCopyWithImpl<$Res>
    implements _$LeagueMemberCopyWith<$Res> {
  __$LeagueMemberCopyWithImpl(this._self, this._then);

  final _LeagueMember _self;
  final $Res Function(_LeagueMember) _then;

/// Create a copy of LeagueMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leagueId = null,Object? userId = null,Object? losses = null,Object? joinedAt = null,}) {
  return _then(_LeagueMember(
leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$League {

 String get id; String get name; String get ownerId; LeagueVisibility get visibility; LeagueSettings get settings; int get season; String get createdAtIso; List<String> get memberIds; String? get inviteCode; Map<String, int> get memberPoints;// User ID -> Points
 Map<String, bool> get eliminatedUsers;
/// Create a copy of League
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeagueCopyWith<League> get copyWith => _$LeagueCopyWithImpl<League>(this as League, _$identity);

  /// Serializes this League to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is League&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.season, season) || other.season == season)&&(identical(other.createdAtIso, createdAtIso) || other.createdAtIso == createdAtIso)&&const DeepCollectionEquality().equals(other.memberIds, memberIds)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&const DeepCollectionEquality().equals(other.memberPoints, memberPoints)&&const DeepCollectionEquality().equals(other.eliminatedUsers, eliminatedUsers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,ownerId,visibility,settings,season,createdAtIso,const DeepCollectionEquality().hash(memberIds),inviteCode,const DeepCollectionEquality().hash(memberPoints),const DeepCollectionEquality().hash(eliminatedUsers));

@override
String toString() {
  return 'League(id: $id, name: $name, ownerId: $ownerId, visibility: $visibility, settings: $settings, season: $season, createdAtIso: $createdAtIso, memberIds: $memberIds, inviteCode: $inviteCode, memberPoints: $memberPoints, eliminatedUsers: $eliminatedUsers)';
}


}

/// @nodoc
abstract mixin class $LeagueCopyWith<$Res>  {
  factory $LeagueCopyWith(League value, $Res Function(League) _then) = _$LeagueCopyWithImpl;
@useResult
$Res call({
 String id, String name, String ownerId, LeagueVisibility visibility, LeagueSettings settings, int season, String createdAtIso, List<String> memberIds, String? inviteCode, Map<String, int> memberPoints, Map<String, bool> eliminatedUsers
});


$LeagueSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class _$LeagueCopyWithImpl<$Res>
    implements $LeagueCopyWith<$Res> {
  _$LeagueCopyWithImpl(this._self, this._then);

  final League _self;
  final $Res Function(League) _then;

/// Create a copy of League
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? ownerId = null,Object? visibility = null,Object? settings = null,Object? season = null,Object? createdAtIso = null,Object? memberIds = null,Object? inviteCode = freezed,Object? memberPoints = null,Object? eliminatedUsers = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as LeagueVisibility,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as LeagueSettings,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int,createdAtIso: null == createdAtIso ? _self.createdAtIso : createdAtIso // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self.memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,memberPoints: null == memberPoints ? _self.memberPoints : memberPoints // ignore: cast_nullable_to_non_nullable
as Map<String, int>,eliminatedUsers: null == eliminatedUsers ? _self.eliminatedUsers : eliminatedUsers // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,
  ));
}
/// Create a copy of League
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeagueSettingsCopyWith<$Res> get settings {
  
  return $LeagueSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// Adds pattern-matching-related methods to [League].
extension LeaguePatterns on League {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _League value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _League() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _League value)  $default,){
final _that = this;
switch (_that) {
case _League():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _League value)?  $default,){
final _that = this;
switch (_that) {
case _League() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String ownerId,  LeagueVisibility visibility,  LeagueSettings settings,  int season,  String createdAtIso,  List<String> memberIds,  String? inviteCode,  Map<String, int> memberPoints,  Map<String, bool> eliminatedUsers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _League() when $default != null:
return $default(_that.id,_that.name,_that.ownerId,_that.visibility,_that.settings,_that.season,_that.createdAtIso,_that.memberIds,_that.inviteCode,_that.memberPoints,_that.eliminatedUsers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String ownerId,  LeagueVisibility visibility,  LeagueSettings settings,  int season,  String createdAtIso,  List<String> memberIds,  String? inviteCode,  Map<String, int> memberPoints,  Map<String, bool> eliminatedUsers)  $default,) {final _that = this;
switch (_that) {
case _League():
return $default(_that.id,_that.name,_that.ownerId,_that.visibility,_that.settings,_that.season,_that.createdAtIso,_that.memberIds,_that.inviteCode,_that.memberPoints,_that.eliminatedUsers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String ownerId,  LeagueVisibility visibility,  LeagueSettings settings,  int season,  String createdAtIso,  List<String> memberIds,  String? inviteCode,  Map<String, int> memberPoints,  Map<String, bool> eliminatedUsers)?  $default,) {final _that = this;
switch (_that) {
case _League() when $default != null:
return $default(_that.id,_that.name,_that.ownerId,_that.visibility,_that.settings,_that.season,_that.createdAtIso,_that.memberIds,_that.inviteCode,_that.memberPoints,_that.eliminatedUsers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _League implements League {
  const _League({required this.id, required this.name, required this.ownerId, required this.visibility, required this.settings, required this.season, required this.createdAtIso, required final  List<String> memberIds, this.inviteCode, final  Map<String, int> memberPoints = const {}, final  Map<String, bool> eliminatedUsers = const {}}): _memberIds = memberIds,_memberPoints = memberPoints,_eliminatedUsers = eliminatedUsers;
  factory _League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

@override final  String id;
@override final  String name;
@override final  String ownerId;
@override final  LeagueVisibility visibility;
@override final  LeagueSettings settings;
@override final  int season;
@override final  String createdAtIso;
 final  List<String> _memberIds;
@override List<String> get memberIds {
  if (_memberIds is EqualUnmodifiableListView) return _memberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberIds);
}

@override final  String? inviteCode;
 final  Map<String, int> _memberPoints;
@override@JsonKey() Map<String, int> get memberPoints {
  if (_memberPoints is EqualUnmodifiableMapView) return _memberPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_memberPoints);
}

// User ID -> Points
 final  Map<String, bool> _eliminatedUsers;
// User ID -> Points
@override@JsonKey() Map<String, bool> get eliminatedUsers {
  if (_eliminatedUsers is EqualUnmodifiableMapView) return _eliminatedUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_eliminatedUsers);
}


/// Create a copy of League
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeagueCopyWith<_League> get copyWith => __$LeagueCopyWithImpl<_League>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeagueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _League&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.season, season) || other.season == season)&&(identical(other.createdAtIso, createdAtIso) || other.createdAtIso == createdAtIso)&&const DeepCollectionEquality().equals(other._memberIds, _memberIds)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&const DeepCollectionEquality().equals(other._memberPoints, _memberPoints)&&const DeepCollectionEquality().equals(other._eliminatedUsers, _eliminatedUsers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,ownerId,visibility,settings,season,createdAtIso,const DeepCollectionEquality().hash(_memberIds),inviteCode,const DeepCollectionEquality().hash(_memberPoints),const DeepCollectionEquality().hash(_eliminatedUsers));

@override
String toString() {
  return 'League(id: $id, name: $name, ownerId: $ownerId, visibility: $visibility, settings: $settings, season: $season, createdAtIso: $createdAtIso, memberIds: $memberIds, inviteCode: $inviteCode, memberPoints: $memberPoints, eliminatedUsers: $eliminatedUsers)';
}


}

/// @nodoc
abstract mixin class _$LeagueCopyWith<$Res> implements $LeagueCopyWith<$Res> {
  factory _$LeagueCopyWith(_League value, $Res Function(_League) _then) = __$LeagueCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String ownerId, LeagueVisibility visibility, LeagueSettings settings, int season, String createdAtIso, List<String> memberIds, String? inviteCode, Map<String, int> memberPoints, Map<String, bool> eliminatedUsers
});


@override $LeagueSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class __$LeagueCopyWithImpl<$Res>
    implements _$LeagueCopyWith<$Res> {
  __$LeagueCopyWithImpl(this._self, this._then);

  final _League _self;
  final $Res Function(_League) _then;

/// Create a copy of League
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? ownerId = null,Object? visibility = null,Object? settings = null,Object? season = null,Object? createdAtIso = null,Object? memberIds = null,Object? inviteCode = freezed,Object? memberPoints = null,Object? eliminatedUsers = null,}) {
  return _then(_League(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as LeagueVisibility,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as LeagueSettings,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int,createdAtIso: null == createdAtIso ? _self.createdAtIso : createdAtIso // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self._memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,memberPoints: null == memberPoints ? _self._memberPoints : memberPoints // ignore: cast_nullable_to_non_nullable
as Map<String, int>,eliminatedUsers: null == eliminatedUsers ? _self._eliminatedUsers : eliminatedUsers // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,
  ));
}

/// Create a copy of League
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeagueSettingsCopyWith<$Res> get settings {
  
  return $LeagueSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
