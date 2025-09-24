// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pick.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Pick {

 String get id; String get leagueId; String get userId; int get week; String get teamId; String get madeAtIso; bool get locked; PickResult? get result;
/// Create a copy of Pick
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PickCopyWith<Pick> get copyWith => _$PickCopyWithImpl<Pick>(this as Pick, _$identity);

  /// Serializes this Pick to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Pick&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.week, week) || other.week == week)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.madeAtIso, madeAtIso) || other.madeAtIso == madeAtIso)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,userId,week,teamId,madeAtIso,locked,result);

@override
String toString() {
  return 'Pick(id: $id, leagueId: $leagueId, userId: $userId, week: $week, teamId: $teamId, madeAtIso: $madeAtIso, locked: $locked, result: $result)';
}


}

/// @nodoc
abstract mixin class $PickCopyWith<$Res>  {
  factory $PickCopyWith(Pick value, $Res Function(Pick) _then) = _$PickCopyWithImpl;
@useResult
$Res call({
 String id, String leagueId, String userId, int week, String teamId, String madeAtIso, bool locked, PickResult? result
});




}
/// @nodoc
class _$PickCopyWithImpl<$Res>
    implements $PickCopyWith<$Res> {
  _$PickCopyWithImpl(this._self, this._then);

  final Pick _self;
  final $Res Function(Pick) _then;

/// Create a copy of Pick
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? leagueId = null,Object? userId = null,Object? week = null,Object? teamId = null,Object? madeAtIso = null,Object? locked = null,Object? result = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,madeAtIso: null == madeAtIso ? _self.madeAtIso : madeAtIso // ignore: cast_nullable_to_non_nullable
as String,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as PickResult?,
  ));
}

}


/// Adds pattern-matching-related methods to [Pick].
extension PickPatterns on Pick {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Pick value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Pick() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Pick value)  $default,){
final _that = this;
switch (_that) {
case _Pick():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Pick value)?  $default,){
final _that = this;
switch (_that) {
case _Pick() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String leagueId,  String userId,  int week,  String teamId,  String madeAtIso,  bool locked,  PickResult? result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Pick() when $default != null:
return $default(_that.id,_that.leagueId,_that.userId,_that.week,_that.teamId,_that.madeAtIso,_that.locked,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String leagueId,  String userId,  int week,  String teamId,  String madeAtIso,  bool locked,  PickResult? result)  $default,) {final _that = this;
switch (_that) {
case _Pick():
return $default(_that.id,_that.leagueId,_that.userId,_that.week,_that.teamId,_that.madeAtIso,_that.locked,_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String leagueId,  String userId,  int week,  String teamId,  String madeAtIso,  bool locked,  PickResult? result)?  $default,) {final _that = this;
switch (_that) {
case _Pick() when $default != null:
return $default(_that.id,_that.leagueId,_that.userId,_that.week,_that.teamId,_that.madeAtIso,_that.locked,_that.result);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Pick implements Pick {
  const _Pick({required this.id, required this.leagueId, required this.userId, required this.week, required this.teamId, required this.madeAtIso, required this.locked, this.result});
  factory _Pick.fromJson(Map<String, dynamic> json) => _$PickFromJson(json);

@override final  String id;
@override final  String leagueId;
@override final  String userId;
@override final  int week;
@override final  String teamId;
@override final  String madeAtIso;
@override final  bool locked;
@override final  PickResult? result;

/// Create a copy of Pick
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PickCopyWith<_Pick> get copyWith => __$PickCopyWithImpl<_Pick>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PickToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pick&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.week, week) || other.week == week)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.madeAtIso, madeAtIso) || other.madeAtIso == madeAtIso)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,userId,week,teamId,madeAtIso,locked,result);

@override
String toString() {
  return 'Pick(id: $id, leagueId: $leagueId, userId: $userId, week: $week, teamId: $teamId, madeAtIso: $madeAtIso, locked: $locked, result: $result)';
}


}

/// @nodoc
abstract mixin class _$PickCopyWith<$Res> implements $PickCopyWith<$Res> {
  factory _$PickCopyWith(_Pick value, $Res Function(_Pick) _then) = __$PickCopyWithImpl;
@override @useResult
$Res call({
 String id, String leagueId, String userId, int week, String teamId, String madeAtIso, bool locked, PickResult? result
});




}
/// @nodoc
class __$PickCopyWithImpl<$Res>
    implements _$PickCopyWith<$Res> {
  __$PickCopyWithImpl(this._self, this._then);

  final _Pick _self;
  final $Res Function(_Pick) _then;

/// Create a copy of Pick
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? leagueId = null,Object? userId = null,Object? week = null,Object? teamId = null,Object? madeAtIso = null,Object? locked = null,Object? result = freezed,}) {
  return _then(_Pick(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,madeAtIso: null == madeAtIso ? _self.madeAtIso : madeAtIso // ignore: cast_nullable_to_non_nullable
as String,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as PickResult?,
  ));
}


}

// dart format on
