// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Team {

 String get id; String get espnTeamId; String get name; String get abbreviation; String get city; String get conference; String get division; String? get logoUrl; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamCopyWith<Team> get copyWith => _$TeamCopyWithImpl<Team>(this as Team, _$identity);

  /// Serializes this Team to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Team&&(identical(other.id, id) || other.id == id)&&(identical(other.espnTeamId, espnTeamId) || other.espnTeamId == espnTeamId)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.city, city) || other.city == city)&&(identical(other.conference, conference) || other.conference == conference)&&(identical(other.division, division) || other.division == division)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,espnTeamId,name,abbreviation,city,conference,division,logoUrl,createdAt,updatedAt);

@override
String toString() {
  return 'Team(id: $id, espnTeamId: $espnTeamId, name: $name, abbreviation: $abbreviation, city: $city, conference: $conference, division: $division, logoUrl: $logoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TeamCopyWith<$Res>  {
  factory $TeamCopyWith(Team value, $Res Function(Team) _then) = _$TeamCopyWithImpl;
@useResult
$Res call({
 String id, String espnTeamId, String name, String abbreviation, String city, String conference, String division, String? logoUrl, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$TeamCopyWithImpl<$Res>
    implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._self, this._then);

  final Team _self;
  final $Res Function(Team) _then;

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? espnTeamId = null,Object? name = null,Object? abbreviation = null,Object? city = null,Object? conference = null,Object? division = null,Object? logoUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,espnTeamId: null == espnTeamId ? _self.espnTeamId : espnTeamId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,conference: null == conference ? _self.conference : conference // ignore: cast_nullable_to_non_nullable
as String,division: null == division ? _self.division : division // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Team].
extension TeamPatterns on Team {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Team value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Team() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Team value)  $default,){
final _that = this;
switch (_that) {
case _Team():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Team value)?  $default,){
final _that = this;
switch (_that) {
case _Team() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String espnTeamId,  String name,  String abbreviation,  String city,  String conference,  String division,  String? logoUrl,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Team() when $default != null:
return $default(_that.id,_that.espnTeamId,_that.name,_that.abbreviation,_that.city,_that.conference,_that.division,_that.logoUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String espnTeamId,  String name,  String abbreviation,  String city,  String conference,  String division,  String? logoUrl,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Team():
return $default(_that.id,_that.espnTeamId,_that.name,_that.abbreviation,_that.city,_that.conference,_that.division,_that.logoUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String espnTeamId,  String name,  String abbreviation,  String city,  String conference,  String division,  String? logoUrl,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Team() when $default != null:
return $default(_that.id,_that.espnTeamId,_that.name,_that.abbreviation,_that.city,_that.conference,_that.division,_that.logoUrl,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Team implements Team {
  const _Team({required this.id, required this.espnTeamId, required this.name, required this.abbreviation, required this.city, required this.conference, required this.division, this.logoUrl, required this.createdAt, required this.updatedAt});
  factory _Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

@override final  String id;
@override final  String espnTeamId;
@override final  String name;
@override final  String abbreviation;
@override final  String city;
@override final  String conference;
@override final  String division;
@override final  String? logoUrl;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamCopyWith<_Team> get copyWith => __$TeamCopyWithImpl<_Team>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Team&&(identical(other.id, id) || other.id == id)&&(identical(other.espnTeamId, espnTeamId) || other.espnTeamId == espnTeamId)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.city, city) || other.city == city)&&(identical(other.conference, conference) || other.conference == conference)&&(identical(other.division, division) || other.division == division)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,espnTeamId,name,abbreviation,city,conference,division,logoUrl,createdAt,updatedAt);

@override
String toString() {
  return 'Team(id: $id, espnTeamId: $espnTeamId, name: $name, abbreviation: $abbreviation, city: $city, conference: $conference, division: $division, logoUrl: $logoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TeamCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$TeamCopyWith(_Team value, $Res Function(_Team) _then) = __$TeamCopyWithImpl;
@override @useResult
$Res call({
 String id, String espnTeamId, String name, String abbreviation, String city, String conference, String division, String? logoUrl, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$TeamCopyWithImpl<$Res>
    implements _$TeamCopyWith<$Res> {
  __$TeamCopyWithImpl(this._self, this._then);

  final _Team _self;
  final $Res Function(_Team) _then;

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? espnTeamId = null,Object? name = null,Object? abbreviation = null,Object? city = null,Object? conference = null,Object? division = null,Object? logoUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Team(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,espnTeamId: null == espnTeamId ? _self.espnTeamId : espnTeamId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,conference: null == conference ? _self.conference : conference // ignore: cast_nullable_to_non_nullable
as String,division: null == division ? _self.division : division // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$TeamRecord {

 String get id; String get teamId; int get season; int get week; int get wins; int get losses; int get ties; DateTime get lastUpdated;
/// Create a copy of TeamRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamRecordCopyWith<TeamRecord> get copyWith => _$TeamRecordCopyWithImpl<TeamRecord>(this as TeamRecord, _$identity);

  /// Serializes this TeamRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.season, season) || other.season == season)&&(identical(other.week, week) || other.week == week)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.ties, ties) || other.ties == ties)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,teamId,season,week,wins,losses,ties,lastUpdated);

@override
String toString() {
  return 'TeamRecord(id: $id, teamId: $teamId, season: $season, week: $week, wins: $wins, losses: $losses, ties: $ties, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $TeamRecordCopyWith<$Res>  {
  factory $TeamRecordCopyWith(TeamRecord value, $Res Function(TeamRecord) _then) = _$TeamRecordCopyWithImpl;
@useResult
$Res call({
 String id, String teamId, int season, int week, int wins, int losses, int ties, DateTime lastUpdated
});




}
/// @nodoc
class _$TeamRecordCopyWithImpl<$Res>
    implements $TeamRecordCopyWith<$Res> {
  _$TeamRecordCopyWithImpl(this._self, this._then);

  final TeamRecord _self;
  final $Res Function(TeamRecord) _then;

/// Create a copy of TeamRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? teamId = null,Object? season = null,Object? week = null,Object? wins = null,Object? losses = null,Object? ties = null,Object? lastUpdated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,ties: null == ties ? _self.ties : ties // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamRecord].
extension TeamRecordPatterns on TeamRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamRecord value)  $default,){
final _that = this;
switch (_that) {
case _TeamRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamRecord value)?  $default,){
final _that = this;
switch (_that) {
case _TeamRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String teamId,  int season,  int week,  int wins,  int losses,  int ties,  DateTime lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamRecord() when $default != null:
return $default(_that.id,_that.teamId,_that.season,_that.week,_that.wins,_that.losses,_that.ties,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String teamId,  int season,  int week,  int wins,  int losses,  int ties,  DateTime lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _TeamRecord():
return $default(_that.id,_that.teamId,_that.season,_that.week,_that.wins,_that.losses,_that.ties,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String teamId,  int season,  int week,  int wins,  int losses,  int ties,  DateTime lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _TeamRecord() when $default != null:
return $default(_that.id,_that.teamId,_that.season,_that.week,_that.wins,_that.losses,_that.ties,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamRecord implements TeamRecord {
  const _TeamRecord({required this.id, required this.teamId, required this.season, required this.week, required this.wins, required this.losses, required this.ties, required this.lastUpdated});
  factory _TeamRecord.fromJson(Map<String, dynamic> json) => _$TeamRecordFromJson(json);

@override final  String id;
@override final  String teamId;
@override final  int season;
@override final  int week;
@override final  int wins;
@override final  int losses;
@override final  int ties;
@override final  DateTime lastUpdated;

/// Create a copy of TeamRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamRecordCopyWith<_TeamRecord> get copyWith => __$TeamRecordCopyWithImpl<_TeamRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.season, season) || other.season == season)&&(identical(other.week, week) || other.week == week)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.ties, ties) || other.ties == ties)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,teamId,season,week,wins,losses,ties,lastUpdated);

@override
String toString() {
  return 'TeamRecord(id: $id, teamId: $teamId, season: $season, week: $week, wins: $wins, losses: $losses, ties: $ties, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$TeamRecordCopyWith<$Res> implements $TeamRecordCopyWith<$Res> {
  factory _$TeamRecordCopyWith(_TeamRecord value, $Res Function(_TeamRecord) _then) = __$TeamRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String teamId, int season, int week, int wins, int losses, int ties, DateTime lastUpdated
});




}
/// @nodoc
class __$TeamRecordCopyWithImpl<$Res>
    implements _$TeamRecordCopyWith<$Res> {
  __$TeamRecordCopyWithImpl(this._self, this._then);

  final _TeamRecord _self;
  final $Res Function(_TeamRecord) _then;

/// Create a copy of TeamRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? teamId = null,Object? season = null,Object? week = null,Object? wins = null,Object? losses = null,Object? ties = null,Object? lastUpdated = null,}) {
  return _then(_TeamRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,ties: null == ties ? _self.ties : ties // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$TeamWithRecord {

 Team get team; TeamRecord? get record;
/// Create a copy of TeamWithRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamWithRecordCopyWith<TeamWithRecord> get copyWith => _$TeamWithRecordCopyWithImpl<TeamWithRecord>(this as TeamWithRecord, _$identity);

  /// Serializes this TeamWithRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamWithRecord&&(identical(other.team, team) || other.team == team)&&(identical(other.record, record) || other.record == record));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,record);

@override
String toString() {
  return 'TeamWithRecord(team: $team, record: $record)';
}


}

/// @nodoc
abstract mixin class $TeamWithRecordCopyWith<$Res>  {
  factory $TeamWithRecordCopyWith(TeamWithRecord value, $Res Function(TeamWithRecord) _then) = _$TeamWithRecordCopyWithImpl;
@useResult
$Res call({
 Team team, TeamRecord? record
});


$TeamCopyWith<$Res> get team;$TeamRecordCopyWith<$Res>? get record;

}
/// @nodoc
class _$TeamWithRecordCopyWithImpl<$Res>
    implements $TeamWithRecordCopyWith<$Res> {
  _$TeamWithRecordCopyWithImpl(this._self, this._then);

  final TeamWithRecord _self;
  final $Res Function(TeamWithRecord) _then;

/// Create a copy of TeamWithRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? team = null,Object? record = freezed,}) {
  return _then(_self.copyWith(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team,record: freezed == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as TeamRecord?,
  ));
}
/// Create a copy of TeamWithRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get team {
  
  return $TeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}/// Create a copy of TeamWithRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamRecordCopyWith<$Res>? get record {
    if (_self.record == null) {
    return null;
  }

  return $TeamRecordCopyWith<$Res>(_self.record!, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// Adds pattern-matching-related methods to [TeamWithRecord].
extension TeamWithRecordPatterns on TeamWithRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamWithRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamWithRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamWithRecord value)  $default,){
final _that = this;
switch (_that) {
case _TeamWithRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamWithRecord value)?  $default,){
final _that = this;
switch (_that) {
case _TeamWithRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Team team,  TeamRecord? record)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamWithRecord() when $default != null:
return $default(_that.team,_that.record);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Team team,  TeamRecord? record)  $default,) {final _that = this;
switch (_that) {
case _TeamWithRecord():
return $default(_that.team,_that.record);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Team team,  TeamRecord? record)?  $default,) {final _that = this;
switch (_that) {
case _TeamWithRecord() when $default != null:
return $default(_that.team,_that.record);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamWithRecord implements TeamWithRecord {
  const _TeamWithRecord({required this.team, this.record});
  factory _TeamWithRecord.fromJson(Map<String, dynamic> json) => _$TeamWithRecordFromJson(json);

@override final  Team team;
@override final  TeamRecord? record;

/// Create a copy of TeamWithRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamWithRecordCopyWith<_TeamWithRecord> get copyWith => __$TeamWithRecordCopyWithImpl<_TeamWithRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamWithRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamWithRecord&&(identical(other.team, team) || other.team == team)&&(identical(other.record, record) || other.record == record));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,record);

@override
String toString() {
  return 'TeamWithRecord(team: $team, record: $record)';
}


}

/// @nodoc
abstract mixin class _$TeamWithRecordCopyWith<$Res> implements $TeamWithRecordCopyWith<$Res> {
  factory _$TeamWithRecordCopyWith(_TeamWithRecord value, $Res Function(_TeamWithRecord) _then) = __$TeamWithRecordCopyWithImpl;
@override @useResult
$Res call({
 Team team, TeamRecord? record
});


@override $TeamCopyWith<$Res> get team;@override $TeamRecordCopyWith<$Res>? get record;

}
/// @nodoc
class __$TeamWithRecordCopyWithImpl<$Res>
    implements _$TeamWithRecordCopyWith<$Res> {
  __$TeamWithRecordCopyWithImpl(this._self, this._then);

  final _TeamWithRecord _self;
  final $Res Function(_TeamWithRecord) _then;

/// Create a copy of TeamWithRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? team = null,Object? record = freezed,}) {
  return _then(_TeamWithRecord(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team,record: freezed == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as TeamRecord?,
  ));
}

/// Create a copy of TeamWithRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get team {
  
  return $TeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}/// Create a copy of TeamWithRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamRecordCopyWith<$Res>? get record {
    if (_self.record == null) {
    return null;
  }

  return $TeamRecordCopyWith<$Res>(_self.record!, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}

// dart format on
