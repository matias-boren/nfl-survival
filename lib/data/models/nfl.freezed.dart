// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nfl.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Team {

 String get id; String get name; String get abbreviation; String get city; String? get logoUrl; String? get color; String? get alternateColor;
/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamCopyWith<Team> get copyWith => _$TeamCopyWithImpl<Team>(this as Team, _$identity);

  /// Serializes this Team to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Team&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.city, city) || other.city == city)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.color, color) || other.color == color)&&(identical(other.alternateColor, alternateColor) || other.alternateColor == alternateColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,abbreviation,city,logoUrl,color,alternateColor);

@override
String toString() {
  return 'Team(id: $id, name: $name, abbreviation: $abbreviation, city: $city, logoUrl: $logoUrl, color: $color, alternateColor: $alternateColor)';
}


}

/// @nodoc
abstract mixin class $TeamCopyWith<$Res>  {
  factory $TeamCopyWith(Team value, $Res Function(Team) _then) = _$TeamCopyWithImpl;
@useResult
$Res call({
 String id, String name, String abbreviation, String city, String? logoUrl, String? color, String? alternateColor
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? abbreviation = null,Object? city = null,Object? logoUrl = freezed,Object? color = freezed,Object? alternateColor = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,alternateColor: freezed == alternateColor ? _self.alternateColor : alternateColor // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String abbreviation,  String city,  String? logoUrl,  String? color,  String? alternateColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Team() when $default != null:
return $default(_that.id,_that.name,_that.abbreviation,_that.city,_that.logoUrl,_that.color,_that.alternateColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String abbreviation,  String city,  String? logoUrl,  String? color,  String? alternateColor)  $default,) {final _that = this;
switch (_that) {
case _Team():
return $default(_that.id,_that.name,_that.abbreviation,_that.city,_that.logoUrl,_that.color,_that.alternateColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String abbreviation,  String city,  String? logoUrl,  String? color,  String? alternateColor)?  $default,) {final _that = this;
switch (_that) {
case _Team() when $default != null:
return $default(_that.id,_that.name,_that.abbreviation,_that.city,_that.logoUrl,_that.color,_that.alternateColor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Team implements Team {
  const _Team({required this.id, required this.name, required this.abbreviation, required this.city, this.logoUrl, this.color, this.alternateColor});
  factory _Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

@override final  String id;
@override final  String name;
@override final  String abbreviation;
@override final  String city;
@override final  String? logoUrl;
@override final  String? color;
@override final  String? alternateColor;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Team&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.city, city) || other.city == city)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.color, color) || other.color == color)&&(identical(other.alternateColor, alternateColor) || other.alternateColor == alternateColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,abbreviation,city,logoUrl,color,alternateColor);

@override
String toString() {
  return 'Team(id: $id, name: $name, abbreviation: $abbreviation, city: $city, logoUrl: $logoUrl, color: $color, alternateColor: $alternateColor)';
}


}

/// @nodoc
abstract mixin class _$TeamCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$TeamCopyWith(_Team value, $Res Function(_Team) _then) = __$TeamCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String abbreviation, String city, String? logoUrl, String? color, String? alternateColor
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? abbreviation = null,Object? city = null,Object? logoUrl = freezed,Object? color = freezed,Object? alternateColor = freezed,}) {
  return _then(_Team(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,alternateColor: freezed == alternateColor ? _self.alternateColor : alternateColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Game {

 String get id; Team get homeTeam; Team get awayTeam; int get homeScore; int get awayScore; GameStatus get status; int get quarter; String get timeRemaining; DateTime get date; int get week; int get season;
/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameCopyWith<Game> get copyWith => _$GameCopyWithImpl<Game>(this as Game, _$identity);

  /// Serializes this Game to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Game&&(identical(other.id, id) || other.id == id)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.homeScore, homeScore) || other.homeScore == homeScore)&&(identical(other.awayScore, awayScore) || other.awayScore == awayScore)&&(identical(other.status, status) || other.status == status)&&(identical(other.quarter, quarter) || other.quarter == quarter)&&(identical(other.timeRemaining, timeRemaining) || other.timeRemaining == timeRemaining)&&(identical(other.date, date) || other.date == date)&&(identical(other.week, week) || other.week == week)&&(identical(other.season, season) || other.season == season));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,homeTeam,awayTeam,homeScore,awayScore,status,quarter,timeRemaining,date,week,season);

@override
String toString() {
  return 'Game(id: $id, homeTeam: $homeTeam, awayTeam: $awayTeam, homeScore: $homeScore, awayScore: $awayScore, status: $status, quarter: $quarter, timeRemaining: $timeRemaining, date: $date, week: $week, season: $season)';
}


}

/// @nodoc
abstract mixin class $GameCopyWith<$Res>  {
  factory $GameCopyWith(Game value, $Res Function(Game) _then) = _$GameCopyWithImpl;
@useResult
$Res call({
 String id, Team homeTeam, Team awayTeam, int homeScore, int awayScore, GameStatus status, int quarter, String timeRemaining, DateTime date, int week, int season
});


$TeamCopyWith<$Res> get homeTeam;$TeamCopyWith<$Res> get awayTeam;

}
/// @nodoc
class _$GameCopyWithImpl<$Res>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._self, this._then);

  final Game _self;
  final $Res Function(Game) _then;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? homeTeam = null,Object? awayTeam = null,Object? homeScore = null,Object? awayScore = null,Object? status = null,Object? quarter = null,Object? timeRemaining = null,Object? date = null,Object? week = null,Object? season = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,homeTeam: null == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as Team,awayTeam: null == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as Team,homeScore: null == homeScore ? _self.homeScore : homeScore // ignore: cast_nullable_to_non_nullable
as int,awayScore: null == awayScore ? _self.awayScore : awayScore // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,quarter: null == quarter ? _self.quarter : quarter // ignore: cast_nullable_to_non_nullable
as int,timeRemaining: null == timeRemaining ? _self.timeRemaining : timeRemaining // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get homeTeam {
  
  return $TeamCopyWith<$Res>(_self.homeTeam, (value) {
    return _then(_self.copyWith(homeTeam: value));
  });
}/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get awayTeam {
  
  return $TeamCopyWith<$Res>(_self.awayTeam, (value) {
    return _then(_self.copyWith(awayTeam: value));
  });
}
}


/// Adds pattern-matching-related methods to [Game].
extension GamePatterns on Game {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Game value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Game() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Game value)  $default,){
final _that = this;
switch (_that) {
case _Game():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Game value)?  $default,){
final _that = this;
switch (_that) {
case _Game() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Team homeTeam,  Team awayTeam,  int homeScore,  int awayScore,  GameStatus status,  int quarter,  String timeRemaining,  DateTime date,  int week,  int season)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that.id,_that.homeTeam,_that.awayTeam,_that.homeScore,_that.awayScore,_that.status,_that.quarter,_that.timeRemaining,_that.date,_that.week,_that.season);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Team homeTeam,  Team awayTeam,  int homeScore,  int awayScore,  GameStatus status,  int quarter,  String timeRemaining,  DateTime date,  int week,  int season)  $default,) {final _that = this;
switch (_that) {
case _Game():
return $default(_that.id,_that.homeTeam,_that.awayTeam,_that.homeScore,_that.awayScore,_that.status,_that.quarter,_that.timeRemaining,_that.date,_that.week,_that.season);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Team homeTeam,  Team awayTeam,  int homeScore,  int awayScore,  GameStatus status,  int quarter,  String timeRemaining,  DateTime date,  int week,  int season)?  $default,) {final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that.id,_that.homeTeam,_that.awayTeam,_that.homeScore,_that.awayScore,_that.status,_that.quarter,_that.timeRemaining,_that.date,_that.week,_that.season);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Game implements Game {
  const _Game({required this.id, required this.homeTeam, required this.awayTeam, required this.homeScore, required this.awayScore, required this.status, required this.quarter, required this.timeRemaining, required this.date, required this.week, required this.season});
  factory _Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

@override final  String id;
@override final  Team homeTeam;
@override final  Team awayTeam;
@override final  int homeScore;
@override final  int awayScore;
@override final  GameStatus status;
@override final  int quarter;
@override final  String timeRemaining;
@override final  DateTime date;
@override final  int week;
@override final  int season;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameCopyWith<_Game> get copyWith => __$GameCopyWithImpl<_Game>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Game&&(identical(other.id, id) || other.id == id)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.homeScore, homeScore) || other.homeScore == homeScore)&&(identical(other.awayScore, awayScore) || other.awayScore == awayScore)&&(identical(other.status, status) || other.status == status)&&(identical(other.quarter, quarter) || other.quarter == quarter)&&(identical(other.timeRemaining, timeRemaining) || other.timeRemaining == timeRemaining)&&(identical(other.date, date) || other.date == date)&&(identical(other.week, week) || other.week == week)&&(identical(other.season, season) || other.season == season));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,homeTeam,awayTeam,homeScore,awayScore,status,quarter,timeRemaining,date,week,season);

@override
String toString() {
  return 'Game(id: $id, homeTeam: $homeTeam, awayTeam: $awayTeam, homeScore: $homeScore, awayScore: $awayScore, status: $status, quarter: $quarter, timeRemaining: $timeRemaining, date: $date, week: $week, season: $season)';
}


}

/// @nodoc
abstract mixin class _$GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$GameCopyWith(_Game value, $Res Function(_Game) _then) = __$GameCopyWithImpl;
@override @useResult
$Res call({
 String id, Team homeTeam, Team awayTeam, int homeScore, int awayScore, GameStatus status, int quarter, String timeRemaining, DateTime date, int week, int season
});


@override $TeamCopyWith<$Res> get homeTeam;@override $TeamCopyWith<$Res> get awayTeam;

}
/// @nodoc
class __$GameCopyWithImpl<$Res>
    implements _$GameCopyWith<$Res> {
  __$GameCopyWithImpl(this._self, this._then);

  final _Game _self;
  final $Res Function(_Game) _then;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? homeTeam = null,Object? awayTeam = null,Object? homeScore = null,Object? awayScore = null,Object? status = null,Object? quarter = null,Object? timeRemaining = null,Object? date = null,Object? week = null,Object? season = null,}) {
  return _then(_Game(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,homeTeam: null == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as Team,awayTeam: null == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as Team,homeScore: null == homeScore ? _self.homeScore : homeScore // ignore: cast_nullable_to_non_nullable
as int,awayScore: null == awayScore ? _self.awayScore : awayScore // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,quarter: null == quarter ? _self.quarter : quarter // ignore: cast_nullable_to_non_nullable
as int,timeRemaining: null == timeRemaining ? _self.timeRemaining : timeRemaining // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get homeTeam {
  
  return $TeamCopyWith<$Res>(_self.homeTeam, (value) {
    return _then(_self.copyWith(homeTeam: value));
  });
}/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get awayTeam {
  
  return $TeamCopyWith<$Res>(_self.awayTeam, (value) {
    return _then(_self.copyWith(awayTeam: value));
  });
}
}

// dart format on
