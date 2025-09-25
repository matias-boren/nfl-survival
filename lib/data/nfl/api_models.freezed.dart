// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EspnGame {

 String get id; String get name; String get shortName; EspnDate get date; List<EspnCompetition> get competitions; EspnStatus get status; EspnWeek get week; EspnSeason get season;
/// Create a copy of EspnGame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnGameCopyWith<EspnGame> get copyWith => _$EspnGameCopyWithImpl<EspnGame>(this as EspnGame, _$identity);

  /// Serializes this EspnGame to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnGame&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shortName, shortName) || other.shortName == shortName)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.competitions, competitions)&&(identical(other.status, status) || other.status == status)&&(identical(other.week, week) || other.week == week)&&(identical(other.season, season) || other.season == season));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shortName,date,const DeepCollectionEquality().hash(competitions),status,week,season);

@override
String toString() {
  return 'EspnGame(id: $id, name: $name, shortName: $shortName, date: $date, competitions: $competitions, status: $status, week: $week, season: $season)';
}


}

/// @nodoc
abstract mixin class $EspnGameCopyWith<$Res>  {
  factory $EspnGameCopyWith(EspnGame value, $Res Function(EspnGame) _then) = _$EspnGameCopyWithImpl;
@useResult
$Res call({
 String id, String name, String shortName, EspnDate date, List<EspnCompetition> competitions, EspnStatus status, EspnWeek week, EspnSeason season
});


$EspnDateCopyWith<$Res> get date;$EspnStatusCopyWith<$Res> get status;$EspnWeekCopyWith<$Res> get week;$EspnSeasonCopyWith<$Res> get season;

}
/// @nodoc
class _$EspnGameCopyWithImpl<$Res>
    implements $EspnGameCopyWith<$Res> {
  _$EspnGameCopyWithImpl(this._self, this._then);

  final EspnGame _self;
  final $Res Function(EspnGame) _then;

/// Create a copy of EspnGame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shortName = null,Object? date = null,Object? competitions = null,Object? status = null,Object? week = null,Object? season = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shortName: null == shortName ? _self.shortName : shortName // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as EspnDate,competitions: null == competitions ? _self.competitions : competitions // ignore: cast_nullable_to_non_nullable
as List<EspnCompetition>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EspnStatus,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as EspnWeek,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as EspnSeason,
  ));
}
/// Create a copy of EspnGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnDateCopyWith<$Res> get date {
  
  return $EspnDateCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of EspnGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnStatusCopyWith<$Res> get status {
  
  return $EspnStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of EspnGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnWeekCopyWith<$Res> get week {
  
  return $EspnWeekCopyWith<$Res>(_self.week, (value) {
    return _then(_self.copyWith(week: value));
  });
}/// Create a copy of EspnGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnSeasonCopyWith<$Res> get season {
  
  return $EspnSeasonCopyWith<$Res>(_self.season, (value) {
    return _then(_self.copyWith(season: value));
  });
}
}


/// Adds pattern-matching-related methods to [EspnGame].
extension EspnGamePatterns on EspnGame {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnGame value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnGame() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnGame value)  $default,){
final _that = this;
switch (_that) {
case _EspnGame():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnGame value)?  $default,){
final _that = this;
switch (_that) {
case _EspnGame() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String shortName,  EspnDate date,  List<EspnCompetition> competitions,  EspnStatus status,  EspnWeek week,  EspnSeason season)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnGame() when $default != null:
return $default(_that.id,_that.name,_that.shortName,_that.date,_that.competitions,_that.status,_that.week,_that.season);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String shortName,  EspnDate date,  List<EspnCompetition> competitions,  EspnStatus status,  EspnWeek week,  EspnSeason season)  $default,) {final _that = this;
switch (_that) {
case _EspnGame():
return $default(_that.id,_that.name,_that.shortName,_that.date,_that.competitions,_that.status,_that.week,_that.season);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String shortName,  EspnDate date,  List<EspnCompetition> competitions,  EspnStatus status,  EspnWeek week,  EspnSeason season)?  $default,) {final _that = this;
switch (_that) {
case _EspnGame() when $default != null:
return $default(_that.id,_that.name,_that.shortName,_that.date,_that.competitions,_that.status,_that.week,_that.season);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnGame implements EspnGame {
  const _EspnGame({required this.id, required this.name, required this.shortName, required this.date, required final  List<EspnCompetition> competitions, required this.status, required this.week, required this.season}): _competitions = competitions;
  factory _EspnGame.fromJson(Map<String, dynamic> json) => _$EspnGameFromJson(json);

@override final  String id;
@override final  String name;
@override final  String shortName;
@override final  EspnDate date;
 final  List<EspnCompetition> _competitions;
@override List<EspnCompetition> get competitions {
  if (_competitions is EqualUnmodifiableListView) return _competitions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_competitions);
}

@override final  EspnStatus status;
@override final  EspnWeek week;
@override final  EspnSeason season;

/// Create a copy of EspnGame
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnGameCopyWith<_EspnGame> get copyWith => __$EspnGameCopyWithImpl<_EspnGame>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnGameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnGame&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shortName, shortName) || other.shortName == shortName)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._competitions, _competitions)&&(identical(other.status, status) || other.status == status)&&(identical(other.week, week) || other.week == week)&&(identical(other.season, season) || other.season == season));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shortName,date,const DeepCollectionEquality().hash(_competitions),status,week,season);

@override
String toString() {
  return 'EspnGame(id: $id, name: $name, shortName: $shortName, date: $date, competitions: $competitions, status: $status, week: $week, season: $season)';
}


}

/// @nodoc
abstract mixin class _$EspnGameCopyWith<$Res> implements $EspnGameCopyWith<$Res> {
  factory _$EspnGameCopyWith(_EspnGame value, $Res Function(_EspnGame) _then) = __$EspnGameCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String shortName, EspnDate date, List<EspnCompetition> competitions, EspnStatus status, EspnWeek week, EspnSeason season
});


@override $EspnDateCopyWith<$Res> get date;@override $EspnStatusCopyWith<$Res> get status;@override $EspnWeekCopyWith<$Res> get week;@override $EspnSeasonCopyWith<$Res> get season;

}
/// @nodoc
class __$EspnGameCopyWithImpl<$Res>
    implements _$EspnGameCopyWith<$Res> {
  __$EspnGameCopyWithImpl(this._self, this._then);

  final _EspnGame _self;
  final $Res Function(_EspnGame) _then;

/// Create a copy of EspnGame
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shortName = null,Object? date = null,Object? competitions = null,Object? status = null,Object? week = null,Object? season = null,}) {
  return _then(_EspnGame(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shortName: null == shortName ? _self.shortName : shortName // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as EspnDate,competitions: null == competitions ? _self._competitions : competitions // ignore: cast_nullable_to_non_nullable
as List<EspnCompetition>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EspnStatus,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as EspnWeek,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as EspnSeason,
  ));
}

/// Create a copy of EspnGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnDateCopyWith<$Res> get date {
  
  return $EspnDateCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of EspnGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnStatusCopyWith<$Res> get status {
  
  return $EspnStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of EspnGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnWeekCopyWith<$Res> get week {
  
  return $EspnWeekCopyWith<$Res>(_self.week, (value) {
    return _then(_self.copyWith(week: value));
  });
}/// Create a copy of EspnGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnSeasonCopyWith<$Res> get season {
  
  return $EspnSeasonCopyWith<$Res>(_self.season, (value) {
    return _then(_self.copyWith(season: value));
  });
}
}


/// @nodoc
mixin _$EspnDate {

 String get date;
/// Create a copy of EspnDate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnDateCopyWith<EspnDate> get copyWith => _$EspnDateCopyWithImpl<EspnDate>(this as EspnDate, _$identity);

  /// Serializes this EspnDate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnDate&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'EspnDate(date: $date)';
}


}

/// @nodoc
abstract mixin class $EspnDateCopyWith<$Res>  {
  factory $EspnDateCopyWith(EspnDate value, $Res Function(EspnDate) _then) = _$EspnDateCopyWithImpl;
@useResult
$Res call({
 String date
});




}
/// @nodoc
class _$EspnDateCopyWithImpl<$Res>
    implements $EspnDateCopyWith<$Res> {
  _$EspnDateCopyWithImpl(this._self, this._then);

  final EspnDate _self;
  final $Res Function(EspnDate) _then;

/// Create a copy of EspnDate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnDate].
extension EspnDatePatterns on EspnDate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnDate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnDate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnDate value)  $default,){
final _that = this;
switch (_that) {
case _EspnDate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnDate value)?  $default,){
final _that = this;
switch (_that) {
case _EspnDate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnDate() when $default != null:
return $default(_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date)  $default,) {final _that = this;
switch (_that) {
case _EspnDate():
return $default(_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date)?  $default,) {final _that = this;
switch (_that) {
case _EspnDate() when $default != null:
return $default(_that.date);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnDate implements EspnDate {
  const _EspnDate({required this.date});
  factory _EspnDate.fromJson(Map<String, dynamic> json) => _$EspnDateFromJson(json);

@override final  String date;

/// Create a copy of EspnDate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnDateCopyWith<_EspnDate> get copyWith => __$EspnDateCopyWithImpl<_EspnDate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnDateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnDate&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'EspnDate(date: $date)';
}


}

/// @nodoc
abstract mixin class _$EspnDateCopyWith<$Res> implements $EspnDateCopyWith<$Res> {
  factory _$EspnDateCopyWith(_EspnDate value, $Res Function(_EspnDate) _then) = __$EspnDateCopyWithImpl;
@override @useResult
$Res call({
 String date
});




}
/// @nodoc
class __$EspnDateCopyWithImpl<$Res>
    implements _$EspnDateCopyWith<$Res> {
  __$EspnDateCopyWithImpl(this._self, this._then);

  final _EspnDate _self;
  final $Res Function(_EspnDate) _then;

/// Create a copy of EspnDate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(_EspnDate(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EspnCompetition {

 String get id; String get uid; String get date; String get attendance; EspnType get type; bool get timeValid; List<EspnCompetitor> get competitors; EspnStatus get status; EspnBroadcast? get broadcast; EspnVenue get venue; List<EspnStartDate> get startDate; List<EspnWeather> get weather; EspnReferee? get referee;
/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnCompetitionCopyWith<EspnCompetition> get copyWith => _$EspnCompetitionCopyWithImpl<EspnCompetition>(this as EspnCompetition, _$identity);

  /// Serializes this EspnCompetition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnCompetition&&(identical(other.id, id) || other.id == id)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.date, date) || other.date == date)&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.type, type) || other.type == type)&&(identical(other.timeValid, timeValid) || other.timeValid == timeValid)&&const DeepCollectionEquality().equals(other.competitors, competitors)&&(identical(other.status, status) || other.status == status)&&(identical(other.broadcast, broadcast) || other.broadcast == broadcast)&&(identical(other.venue, venue) || other.venue == venue)&&const DeepCollectionEquality().equals(other.startDate, startDate)&&const DeepCollectionEquality().equals(other.weather, weather)&&(identical(other.referee, referee) || other.referee == referee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,uid,date,attendance,type,timeValid,const DeepCollectionEquality().hash(competitors),status,broadcast,venue,const DeepCollectionEquality().hash(startDate),const DeepCollectionEquality().hash(weather),referee);

@override
String toString() {
  return 'EspnCompetition(id: $id, uid: $uid, date: $date, attendance: $attendance, type: $type, timeValid: $timeValid, competitors: $competitors, status: $status, broadcast: $broadcast, venue: $venue, startDate: $startDate, weather: $weather, referee: $referee)';
}


}

/// @nodoc
abstract mixin class $EspnCompetitionCopyWith<$Res>  {
  factory $EspnCompetitionCopyWith(EspnCompetition value, $Res Function(EspnCompetition) _then) = _$EspnCompetitionCopyWithImpl;
@useResult
$Res call({
 String id, String uid, String date, String attendance, EspnType type, bool timeValid, List<EspnCompetitor> competitors, EspnStatus status, EspnBroadcast? broadcast, EspnVenue venue, List<EspnStartDate> startDate, List<EspnWeather> weather, EspnReferee? referee
});


$EspnTypeCopyWith<$Res> get type;$EspnStatusCopyWith<$Res> get status;$EspnBroadcastCopyWith<$Res>? get broadcast;$EspnVenueCopyWith<$Res> get venue;$EspnRefereeCopyWith<$Res>? get referee;

}
/// @nodoc
class _$EspnCompetitionCopyWithImpl<$Res>
    implements $EspnCompetitionCopyWith<$Res> {
  _$EspnCompetitionCopyWithImpl(this._self, this._then);

  final EspnCompetition _self;
  final $Res Function(EspnCompetition) _then;

/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? uid = null,Object? date = null,Object? attendance = null,Object? type = null,Object? timeValid = null,Object? competitors = null,Object? status = null,Object? broadcast = freezed,Object? venue = null,Object? startDate = null,Object? weather = null,Object? referee = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EspnType,timeValid: null == timeValid ? _self.timeValid : timeValid // ignore: cast_nullable_to_non_nullable
as bool,competitors: null == competitors ? _self.competitors : competitors // ignore: cast_nullable_to_non_nullable
as List<EspnCompetitor>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EspnStatus,broadcast: freezed == broadcast ? _self.broadcast : broadcast // ignore: cast_nullable_to_non_nullable
as EspnBroadcast?,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as EspnVenue,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as List<EspnStartDate>,weather: null == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as List<EspnWeather>,referee: freezed == referee ? _self.referee : referee // ignore: cast_nullable_to_non_nullable
as EspnReferee?,
  ));
}
/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnTypeCopyWith<$Res> get type {
  
  return $EspnTypeCopyWith<$Res>(_self.type, (value) {
    return _then(_self.copyWith(type: value));
  });
}/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnStatusCopyWith<$Res> get status {
  
  return $EspnStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnBroadcastCopyWith<$Res>? get broadcast {
    if (_self.broadcast == null) {
    return null;
  }

  return $EspnBroadcastCopyWith<$Res>(_self.broadcast!, (value) {
    return _then(_self.copyWith(broadcast: value));
  });
}/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnVenueCopyWith<$Res> get venue {
  
  return $EspnVenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnRefereeCopyWith<$Res>? get referee {
    if (_self.referee == null) {
    return null;
  }

  return $EspnRefereeCopyWith<$Res>(_self.referee!, (value) {
    return _then(_self.copyWith(referee: value));
  });
}
}


/// Adds pattern-matching-related methods to [EspnCompetition].
extension EspnCompetitionPatterns on EspnCompetition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnCompetition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnCompetition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnCompetition value)  $default,){
final _that = this;
switch (_that) {
case _EspnCompetition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnCompetition value)?  $default,){
final _that = this;
switch (_that) {
case _EspnCompetition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String uid,  String date,  String attendance,  EspnType type,  bool timeValid,  List<EspnCompetitor> competitors,  EspnStatus status,  EspnBroadcast? broadcast,  EspnVenue venue,  List<EspnStartDate> startDate,  List<EspnWeather> weather,  EspnReferee? referee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnCompetition() when $default != null:
return $default(_that.id,_that.uid,_that.date,_that.attendance,_that.type,_that.timeValid,_that.competitors,_that.status,_that.broadcast,_that.venue,_that.startDate,_that.weather,_that.referee);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String uid,  String date,  String attendance,  EspnType type,  bool timeValid,  List<EspnCompetitor> competitors,  EspnStatus status,  EspnBroadcast? broadcast,  EspnVenue venue,  List<EspnStartDate> startDate,  List<EspnWeather> weather,  EspnReferee? referee)  $default,) {final _that = this;
switch (_that) {
case _EspnCompetition():
return $default(_that.id,_that.uid,_that.date,_that.attendance,_that.type,_that.timeValid,_that.competitors,_that.status,_that.broadcast,_that.venue,_that.startDate,_that.weather,_that.referee);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String uid,  String date,  String attendance,  EspnType type,  bool timeValid,  List<EspnCompetitor> competitors,  EspnStatus status,  EspnBroadcast? broadcast,  EspnVenue venue,  List<EspnStartDate> startDate,  List<EspnWeather> weather,  EspnReferee? referee)?  $default,) {final _that = this;
switch (_that) {
case _EspnCompetition() when $default != null:
return $default(_that.id,_that.uid,_that.date,_that.attendance,_that.type,_that.timeValid,_that.competitors,_that.status,_that.broadcast,_that.venue,_that.startDate,_that.weather,_that.referee);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnCompetition implements EspnCompetition {
  const _EspnCompetition({required this.id, required this.uid, required this.date, required this.attendance, required this.type, required this.timeValid, required final  List<EspnCompetitor> competitors, required this.status, required this.broadcast, required this.venue, required final  List<EspnStartDate> startDate, required final  List<EspnWeather> weather, required this.referee}): _competitors = competitors,_startDate = startDate,_weather = weather;
  factory _EspnCompetition.fromJson(Map<String, dynamic> json) => _$EspnCompetitionFromJson(json);

@override final  String id;
@override final  String uid;
@override final  String date;
@override final  String attendance;
@override final  EspnType type;
@override final  bool timeValid;
 final  List<EspnCompetitor> _competitors;
@override List<EspnCompetitor> get competitors {
  if (_competitors is EqualUnmodifiableListView) return _competitors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_competitors);
}

@override final  EspnStatus status;
@override final  EspnBroadcast? broadcast;
@override final  EspnVenue venue;
 final  List<EspnStartDate> _startDate;
@override List<EspnStartDate> get startDate {
  if (_startDate is EqualUnmodifiableListView) return _startDate;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_startDate);
}

 final  List<EspnWeather> _weather;
@override List<EspnWeather> get weather {
  if (_weather is EqualUnmodifiableListView) return _weather;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weather);
}

@override final  EspnReferee? referee;

/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnCompetitionCopyWith<_EspnCompetition> get copyWith => __$EspnCompetitionCopyWithImpl<_EspnCompetition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnCompetitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnCompetition&&(identical(other.id, id) || other.id == id)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.date, date) || other.date == date)&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.type, type) || other.type == type)&&(identical(other.timeValid, timeValid) || other.timeValid == timeValid)&&const DeepCollectionEquality().equals(other._competitors, _competitors)&&(identical(other.status, status) || other.status == status)&&(identical(other.broadcast, broadcast) || other.broadcast == broadcast)&&(identical(other.venue, venue) || other.venue == venue)&&const DeepCollectionEquality().equals(other._startDate, _startDate)&&const DeepCollectionEquality().equals(other._weather, _weather)&&(identical(other.referee, referee) || other.referee == referee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,uid,date,attendance,type,timeValid,const DeepCollectionEquality().hash(_competitors),status,broadcast,venue,const DeepCollectionEquality().hash(_startDate),const DeepCollectionEquality().hash(_weather),referee);

@override
String toString() {
  return 'EspnCompetition(id: $id, uid: $uid, date: $date, attendance: $attendance, type: $type, timeValid: $timeValid, competitors: $competitors, status: $status, broadcast: $broadcast, venue: $venue, startDate: $startDate, weather: $weather, referee: $referee)';
}


}

/// @nodoc
abstract mixin class _$EspnCompetitionCopyWith<$Res> implements $EspnCompetitionCopyWith<$Res> {
  factory _$EspnCompetitionCopyWith(_EspnCompetition value, $Res Function(_EspnCompetition) _then) = __$EspnCompetitionCopyWithImpl;
@override @useResult
$Res call({
 String id, String uid, String date, String attendance, EspnType type, bool timeValid, List<EspnCompetitor> competitors, EspnStatus status, EspnBroadcast? broadcast, EspnVenue venue, List<EspnStartDate> startDate, List<EspnWeather> weather, EspnReferee? referee
});


@override $EspnTypeCopyWith<$Res> get type;@override $EspnStatusCopyWith<$Res> get status;@override $EspnBroadcastCopyWith<$Res>? get broadcast;@override $EspnVenueCopyWith<$Res> get venue;@override $EspnRefereeCopyWith<$Res>? get referee;

}
/// @nodoc
class __$EspnCompetitionCopyWithImpl<$Res>
    implements _$EspnCompetitionCopyWith<$Res> {
  __$EspnCompetitionCopyWithImpl(this._self, this._then);

  final _EspnCompetition _self;
  final $Res Function(_EspnCompetition) _then;

/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? uid = null,Object? date = null,Object? attendance = null,Object? type = null,Object? timeValid = null,Object? competitors = null,Object? status = null,Object? broadcast = freezed,Object? venue = null,Object? startDate = null,Object? weather = null,Object? referee = freezed,}) {
  return _then(_EspnCompetition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EspnType,timeValid: null == timeValid ? _self.timeValid : timeValid // ignore: cast_nullable_to_non_nullable
as bool,competitors: null == competitors ? _self._competitors : competitors // ignore: cast_nullable_to_non_nullable
as List<EspnCompetitor>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EspnStatus,broadcast: freezed == broadcast ? _self.broadcast : broadcast // ignore: cast_nullable_to_non_nullable
as EspnBroadcast?,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as EspnVenue,startDate: null == startDate ? _self._startDate : startDate // ignore: cast_nullable_to_non_nullable
as List<EspnStartDate>,weather: null == weather ? _self._weather : weather // ignore: cast_nullable_to_non_nullable
as List<EspnWeather>,referee: freezed == referee ? _self.referee : referee // ignore: cast_nullable_to_non_nullable
as EspnReferee?,
  ));
}

/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnTypeCopyWith<$Res> get type {
  
  return $EspnTypeCopyWith<$Res>(_self.type, (value) {
    return _then(_self.copyWith(type: value));
  });
}/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnStatusCopyWith<$Res> get status {
  
  return $EspnStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnBroadcastCopyWith<$Res>? get broadcast {
    if (_self.broadcast == null) {
    return null;
  }

  return $EspnBroadcastCopyWith<$Res>(_self.broadcast!, (value) {
    return _then(_self.copyWith(broadcast: value));
  });
}/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnVenueCopyWith<$Res> get venue {
  
  return $EspnVenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}/// Create a copy of EspnCompetition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnRefereeCopyWith<$Res>? get referee {
    if (_self.referee == null) {
    return null;
  }

  return $EspnRefereeCopyWith<$Res>(_self.referee!, (value) {
    return _then(_self.copyWith(referee: value));
  });
}
}


/// @nodoc
mixin _$EspnCompetitor {

 String get id; String get uid; String get type; String get order; String get homeAway; EspnTeam get team; EspnScore? get score; List<EspnRecord> get records; List<EspnWinner>? get winners; List<EspnStatistic>? get statistics; List<EspnLeader>? get leaders;
/// Create a copy of EspnCompetitor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnCompetitorCopyWith<EspnCompetitor> get copyWith => _$EspnCompetitorCopyWithImpl<EspnCompetitor>(this as EspnCompetitor, _$identity);

  /// Serializes this EspnCompetitor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnCompetitor&&(identical(other.id, id) || other.id == id)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.type, type) || other.type == type)&&(identical(other.order, order) || other.order == order)&&(identical(other.homeAway, homeAway) || other.homeAway == homeAway)&&(identical(other.team, team) || other.team == team)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.records, records)&&const DeepCollectionEquality().equals(other.winners, winners)&&const DeepCollectionEquality().equals(other.statistics, statistics)&&const DeepCollectionEquality().equals(other.leaders, leaders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,uid,type,order,homeAway,team,score,const DeepCollectionEquality().hash(records),const DeepCollectionEquality().hash(winners),const DeepCollectionEquality().hash(statistics),const DeepCollectionEquality().hash(leaders));

@override
String toString() {
  return 'EspnCompetitor(id: $id, uid: $uid, type: $type, order: $order, homeAway: $homeAway, team: $team, score: $score, records: $records, winners: $winners, statistics: $statistics, leaders: $leaders)';
}


}

/// @nodoc
abstract mixin class $EspnCompetitorCopyWith<$Res>  {
  factory $EspnCompetitorCopyWith(EspnCompetitor value, $Res Function(EspnCompetitor) _then) = _$EspnCompetitorCopyWithImpl;
@useResult
$Res call({
 String id, String uid, String type, String order, String homeAway, EspnTeam team, EspnScore? score, List<EspnRecord> records, List<EspnWinner>? winners, List<EspnStatistic>? statistics, List<EspnLeader>? leaders
});


$EspnTeamCopyWith<$Res> get team;$EspnScoreCopyWith<$Res>? get score;

}
/// @nodoc
class _$EspnCompetitorCopyWithImpl<$Res>
    implements $EspnCompetitorCopyWith<$Res> {
  _$EspnCompetitorCopyWithImpl(this._self, this._then);

  final EspnCompetitor _self;
  final $Res Function(EspnCompetitor) _then;

/// Create a copy of EspnCompetitor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? uid = null,Object? type = null,Object? order = null,Object? homeAway = null,Object? team = null,Object? score = freezed,Object? records = null,Object? winners = freezed,Object? statistics = freezed,Object? leaders = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as String,homeAway: null == homeAway ? _self.homeAway : homeAway // ignore: cast_nullable_to_non_nullable
as String,team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as EspnTeam,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as EspnScore?,records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<EspnRecord>,winners: freezed == winners ? _self.winners : winners // ignore: cast_nullable_to_non_nullable
as List<EspnWinner>?,statistics: freezed == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as List<EspnStatistic>?,leaders: freezed == leaders ? _self.leaders : leaders // ignore: cast_nullable_to_non_nullable
as List<EspnLeader>?,
  ));
}
/// Create a copy of EspnCompetitor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnTeamCopyWith<$Res> get team {
  
  return $EspnTeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}/// Create a copy of EspnCompetitor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnScoreCopyWith<$Res>? get score {
    if (_self.score == null) {
    return null;
  }

  return $EspnScoreCopyWith<$Res>(_self.score!, (value) {
    return _then(_self.copyWith(score: value));
  });
}
}


/// Adds pattern-matching-related methods to [EspnCompetitor].
extension EspnCompetitorPatterns on EspnCompetitor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnCompetitor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnCompetitor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnCompetitor value)  $default,){
final _that = this;
switch (_that) {
case _EspnCompetitor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnCompetitor value)?  $default,){
final _that = this;
switch (_that) {
case _EspnCompetitor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String uid,  String type,  String order,  String homeAway,  EspnTeam team,  EspnScore? score,  List<EspnRecord> records,  List<EspnWinner>? winners,  List<EspnStatistic>? statistics,  List<EspnLeader>? leaders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnCompetitor() when $default != null:
return $default(_that.id,_that.uid,_that.type,_that.order,_that.homeAway,_that.team,_that.score,_that.records,_that.winners,_that.statistics,_that.leaders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String uid,  String type,  String order,  String homeAway,  EspnTeam team,  EspnScore? score,  List<EspnRecord> records,  List<EspnWinner>? winners,  List<EspnStatistic>? statistics,  List<EspnLeader>? leaders)  $default,) {final _that = this;
switch (_that) {
case _EspnCompetitor():
return $default(_that.id,_that.uid,_that.type,_that.order,_that.homeAway,_that.team,_that.score,_that.records,_that.winners,_that.statistics,_that.leaders);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String uid,  String type,  String order,  String homeAway,  EspnTeam team,  EspnScore? score,  List<EspnRecord> records,  List<EspnWinner>? winners,  List<EspnStatistic>? statistics,  List<EspnLeader>? leaders)?  $default,) {final _that = this;
switch (_that) {
case _EspnCompetitor() when $default != null:
return $default(_that.id,_that.uid,_that.type,_that.order,_that.homeAway,_that.team,_that.score,_that.records,_that.winners,_that.statistics,_that.leaders);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnCompetitor implements EspnCompetitor {
  const _EspnCompetitor({required this.id, required this.uid, required this.type, required this.order, required this.homeAway, required this.team, required this.score, required final  List<EspnRecord> records, required final  List<EspnWinner>? winners, required final  List<EspnStatistic>? statistics, required final  List<EspnLeader>? leaders}): _records = records,_winners = winners,_statistics = statistics,_leaders = leaders;
  factory _EspnCompetitor.fromJson(Map<String, dynamic> json) => _$EspnCompetitorFromJson(json);

@override final  String id;
@override final  String uid;
@override final  String type;
@override final  String order;
@override final  String homeAway;
@override final  EspnTeam team;
@override final  EspnScore? score;
 final  List<EspnRecord> _records;
@override List<EspnRecord> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}

 final  List<EspnWinner>? _winners;
@override List<EspnWinner>? get winners {
  final value = _winners;
  if (value == null) return null;
  if (_winners is EqualUnmodifiableListView) return _winners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<EspnStatistic>? _statistics;
@override List<EspnStatistic>? get statistics {
  final value = _statistics;
  if (value == null) return null;
  if (_statistics is EqualUnmodifiableListView) return _statistics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<EspnLeader>? _leaders;
@override List<EspnLeader>? get leaders {
  final value = _leaders;
  if (value == null) return null;
  if (_leaders is EqualUnmodifiableListView) return _leaders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of EspnCompetitor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnCompetitorCopyWith<_EspnCompetitor> get copyWith => __$EspnCompetitorCopyWithImpl<_EspnCompetitor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnCompetitorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnCompetitor&&(identical(other.id, id) || other.id == id)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.type, type) || other.type == type)&&(identical(other.order, order) || other.order == order)&&(identical(other.homeAway, homeAway) || other.homeAway == homeAway)&&(identical(other.team, team) || other.team == team)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._records, _records)&&const DeepCollectionEquality().equals(other._winners, _winners)&&const DeepCollectionEquality().equals(other._statistics, _statistics)&&const DeepCollectionEquality().equals(other._leaders, _leaders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,uid,type,order,homeAway,team,score,const DeepCollectionEquality().hash(_records),const DeepCollectionEquality().hash(_winners),const DeepCollectionEquality().hash(_statistics),const DeepCollectionEquality().hash(_leaders));

@override
String toString() {
  return 'EspnCompetitor(id: $id, uid: $uid, type: $type, order: $order, homeAway: $homeAway, team: $team, score: $score, records: $records, winners: $winners, statistics: $statistics, leaders: $leaders)';
}


}

/// @nodoc
abstract mixin class _$EspnCompetitorCopyWith<$Res> implements $EspnCompetitorCopyWith<$Res> {
  factory _$EspnCompetitorCopyWith(_EspnCompetitor value, $Res Function(_EspnCompetitor) _then) = __$EspnCompetitorCopyWithImpl;
@override @useResult
$Res call({
 String id, String uid, String type, String order, String homeAway, EspnTeam team, EspnScore? score, List<EspnRecord> records, List<EspnWinner>? winners, List<EspnStatistic>? statistics, List<EspnLeader>? leaders
});


@override $EspnTeamCopyWith<$Res> get team;@override $EspnScoreCopyWith<$Res>? get score;

}
/// @nodoc
class __$EspnCompetitorCopyWithImpl<$Res>
    implements _$EspnCompetitorCopyWith<$Res> {
  __$EspnCompetitorCopyWithImpl(this._self, this._then);

  final _EspnCompetitor _self;
  final $Res Function(_EspnCompetitor) _then;

/// Create a copy of EspnCompetitor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? uid = null,Object? type = null,Object? order = null,Object? homeAway = null,Object? team = null,Object? score = freezed,Object? records = null,Object? winners = freezed,Object? statistics = freezed,Object? leaders = freezed,}) {
  return _then(_EspnCompetitor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as String,homeAway: null == homeAway ? _self.homeAway : homeAway // ignore: cast_nullable_to_non_nullable
as String,team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as EspnTeam,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as EspnScore?,records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<EspnRecord>,winners: freezed == winners ? _self._winners : winners // ignore: cast_nullable_to_non_nullable
as List<EspnWinner>?,statistics: freezed == statistics ? _self._statistics : statistics // ignore: cast_nullable_to_non_nullable
as List<EspnStatistic>?,leaders: freezed == leaders ? _self._leaders : leaders // ignore: cast_nullable_to_non_nullable
as List<EspnLeader>?,
  ));
}

/// Create a copy of EspnCompetitor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnTeamCopyWith<$Res> get team {
  
  return $EspnTeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}/// Create a copy of EspnCompetitor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnScoreCopyWith<$Res>? get score {
    if (_self.score == null) {
    return null;
  }

  return $EspnScoreCopyWith<$Res>(_self.score!, (value) {
    return _then(_self.copyWith(score: value));
  });
}
}


/// @nodoc
mixin _$EspnTeam {

 String get id; String get uid; String get location; String get name; String get abbreviation; String get displayName; String get shortDisplayName; String get color; String get alternateColor; bool get isActive; EspnLogo get logo;
/// Create a copy of EspnTeam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnTeamCopyWith<EspnTeam> get copyWith => _$EspnTeamCopyWithImpl<EspnTeam>(this as EspnTeam, _$identity);

  /// Serializes this EspnTeam to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnTeam&&(identical(other.id, id) || other.id == id)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.location, location) || other.location == location)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.shortDisplayName, shortDisplayName) || other.shortDisplayName == shortDisplayName)&&(identical(other.color, color) || other.color == color)&&(identical(other.alternateColor, alternateColor) || other.alternateColor == alternateColor)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.logo, logo) || other.logo == logo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,uid,location,name,abbreviation,displayName,shortDisplayName,color,alternateColor,isActive,logo);

@override
String toString() {
  return 'EspnTeam(id: $id, uid: $uid, location: $location, name: $name, abbreviation: $abbreviation, displayName: $displayName, shortDisplayName: $shortDisplayName, color: $color, alternateColor: $alternateColor, isActive: $isActive, logo: $logo)';
}


}

/// @nodoc
abstract mixin class $EspnTeamCopyWith<$Res>  {
  factory $EspnTeamCopyWith(EspnTeam value, $Res Function(EspnTeam) _then) = _$EspnTeamCopyWithImpl;
@useResult
$Res call({
 String id, String uid, String location, String name, String abbreviation, String displayName, String shortDisplayName, String color, String alternateColor, bool isActive, EspnLogo logo
});


$EspnLogoCopyWith<$Res> get logo;

}
/// @nodoc
class _$EspnTeamCopyWithImpl<$Res>
    implements $EspnTeamCopyWith<$Res> {
  _$EspnTeamCopyWithImpl(this._self, this._then);

  final EspnTeam _self;
  final $Res Function(EspnTeam) _then;

/// Create a copy of EspnTeam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? uid = null,Object? location = null,Object? name = null,Object? abbreviation = null,Object? displayName = null,Object? shortDisplayName = null,Object? color = null,Object? alternateColor = null,Object? isActive = null,Object? logo = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,shortDisplayName: null == shortDisplayName ? _self.shortDisplayName : shortDisplayName // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,alternateColor: null == alternateColor ? _self.alternateColor : alternateColor // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as EspnLogo,
  ));
}
/// Create a copy of EspnTeam
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnLogoCopyWith<$Res> get logo {
  
  return $EspnLogoCopyWith<$Res>(_self.logo, (value) {
    return _then(_self.copyWith(logo: value));
  });
}
}


/// Adds pattern-matching-related methods to [EspnTeam].
extension EspnTeamPatterns on EspnTeam {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnTeam value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnTeam() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnTeam value)  $default,){
final _that = this;
switch (_that) {
case _EspnTeam():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnTeam value)?  $default,){
final _that = this;
switch (_that) {
case _EspnTeam() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String uid,  String location,  String name,  String abbreviation,  String displayName,  String shortDisplayName,  String color,  String alternateColor,  bool isActive,  EspnLogo logo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnTeam() when $default != null:
return $default(_that.id,_that.uid,_that.location,_that.name,_that.abbreviation,_that.displayName,_that.shortDisplayName,_that.color,_that.alternateColor,_that.isActive,_that.logo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String uid,  String location,  String name,  String abbreviation,  String displayName,  String shortDisplayName,  String color,  String alternateColor,  bool isActive,  EspnLogo logo)  $default,) {final _that = this;
switch (_that) {
case _EspnTeam():
return $default(_that.id,_that.uid,_that.location,_that.name,_that.abbreviation,_that.displayName,_that.shortDisplayName,_that.color,_that.alternateColor,_that.isActive,_that.logo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String uid,  String location,  String name,  String abbreviation,  String displayName,  String shortDisplayName,  String color,  String alternateColor,  bool isActive,  EspnLogo logo)?  $default,) {final _that = this;
switch (_that) {
case _EspnTeam() when $default != null:
return $default(_that.id,_that.uid,_that.location,_that.name,_that.abbreviation,_that.displayName,_that.shortDisplayName,_that.color,_that.alternateColor,_that.isActive,_that.logo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnTeam implements EspnTeam {
  const _EspnTeam({required this.id, required this.uid, required this.location, required this.name, required this.abbreviation, required this.displayName, required this.shortDisplayName, required this.color, required this.alternateColor, required this.isActive, required this.logo});
  factory _EspnTeam.fromJson(Map<String, dynamic> json) => _$EspnTeamFromJson(json);

@override final  String id;
@override final  String uid;
@override final  String location;
@override final  String name;
@override final  String abbreviation;
@override final  String displayName;
@override final  String shortDisplayName;
@override final  String color;
@override final  String alternateColor;
@override final  bool isActive;
@override final  EspnLogo logo;

/// Create a copy of EspnTeam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnTeamCopyWith<_EspnTeam> get copyWith => __$EspnTeamCopyWithImpl<_EspnTeam>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnTeamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnTeam&&(identical(other.id, id) || other.id == id)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.location, location) || other.location == location)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.shortDisplayName, shortDisplayName) || other.shortDisplayName == shortDisplayName)&&(identical(other.color, color) || other.color == color)&&(identical(other.alternateColor, alternateColor) || other.alternateColor == alternateColor)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.logo, logo) || other.logo == logo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,uid,location,name,abbreviation,displayName,shortDisplayName,color,alternateColor,isActive,logo);

@override
String toString() {
  return 'EspnTeam(id: $id, uid: $uid, location: $location, name: $name, abbreviation: $abbreviation, displayName: $displayName, shortDisplayName: $shortDisplayName, color: $color, alternateColor: $alternateColor, isActive: $isActive, logo: $logo)';
}


}

/// @nodoc
abstract mixin class _$EspnTeamCopyWith<$Res> implements $EspnTeamCopyWith<$Res> {
  factory _$EspnTeamCopyWith(_EspnTeam value, $Res Function(_EspnTeam) _then) = __$EspnTeamCopyWithImpl;
@override @useResult
$Res call({
 String id, String uid, String location, String name, String abbreviation, String displayName, String shortDisplayName, String color, String alternateColor, bool isActive, EspnLogo logo
});


@override $EspnLogoCopyWith<$Res> get logo;

}
/// @nodoc
class __$EspnTeamCopyWithImpl<$Res>
    implements _$EspnTeamCopyWith<$Res> {
  __$EspnTeamCopyWithImpl(this._self, this._then);

  final _EspnTeam _self;
  final $Res Function(_EspnTeam) _then;

/// Create a copy of EspnTeam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? uid = null,Object? location = null,Object? name = null,Object? abbreviation = null,Object? displayName = null,Object? shortDisplayName = null,Object? color = null,Object? alternateColor = null,Object? isActive = null,Object? logo = null,}) {
  return _then(_EspnTeam(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,shortDisplayName: null == shortDisplayName ? _self.shortDisplayName : shortDisplayName // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,alternateColor: null == alternateColor ? _self.alternateColor : alternateColor // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as EspnLogo,
  ));
}

/// Create a copy of EspnTeam
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnLogoCopyWith<$Res> get logo {
  
  return $EspnLogoCopyWith<$Res>(_self.logo, (value) {
    return _then(_self.copyWith(logo: value));
  });
}
}


/// @nodoc
mixin _$EspnLogo {

 String get href; int get width; int get height; String get alt; List<String> get rel;
/// Create a copy of EspnLogo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnLogoCopyWith<EspnLogo> get copyWith => _$EspnLogoCopyWithImpl<EspnLogo>(this as EspnLogo, _$identity);

  /// Serializes this EspnLogo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnLogo&&(identical(other.href, href) || other.href == href)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.alt, alt) || other.alt == alt)&&const DeepCollectionEquality().equals(other.rel, rel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,href,width,height,alt,const DeepCollectionEquality().hash(rel));

@override
String toString() {
  return 'EspnLogo(href: $href, width: $width, height: $height, alt: $alt, rel: $rel)';
}


}

/// @nodoc
abstract mixin class $EspnLogoCopyWith<$Res>  {
  factory $EspnLogoCopyWith(EspnLogo value, $Res Function(EspnLogo) _then) = _$EspnLogoCopyWithImpl;
@useResult
$Res call({
 String href, int width, int height, String alt, List<String> rel
});




}
/// @nodoc
class _$EspnLogoCopyWithImpl<$Res>
    implements $EspnLogoCopyWith<$Res> {
  _$EspnLogoCopyWithImpl(this._self, this._then);

  final EspnLogo _self;
  final $Res Function(EspnLogo) _then;

/// Create a copy of EspnLogo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? href = null,Object? width = null,Object? height = null,Object? alt = null,Object? rel = null,}) {
  return _then(_self.copyWith(
href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,alt: null == alt ? _self.alt : alt // ignore: cast_nullable_to_non_nullable
as String,rel: null == rel ? _self.rel : rel // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnLogo].
extension EspnLogoPatterns on EspnLogo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnLogo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnLogo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnLogo value)  $default,){
final _that = this;
switch (_that) {
case _EspnLogo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnLogo value)?  $default,){
final _that = this;
switch (_that) {
case _EspnLogo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String href,  int width,  int height,  String alt,  List<String> rel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnLogo() when $default != null:
return $default(_that.href,_that.width,_that.height,_that.alt,_that.rel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String href,  int width,  int height,  String alt,  List<String> rel)  $default,) {final _that = this;
switch (_that) {
case _EspnLogo():
return $default(_that.href,_that.width,_that.height,_that.alt,_that.rel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String href,  int width,  int height,  String alt,  List<String> rel)?  $default,) {final _that = this;
switch (_that) {
case _EspnLogo() when $default != null:
return $default(_that.href,_that.width,_that.height,_that.alt,_that.rel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnLogo implements EspnLogo {
  const _EspnLogo({required this.href, required this.width, required this.height, required this.alt, required final  List<String> rel}): _rel = rel;
  factory _EspnLogo.fromJson(Map<String, dynamic> json) => _$EspnLogoFromJson(json);

@override final  String href;
@override final  int width;
@override final  int height;
@override final  String alt;
 final  List<String> _rel;
@override List<String> get rel {
  if (_rel is EqualUnmodifiableListView) return _rel;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rel);
}


/// Create a copy of EspnLogo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnLogoCopyWith<_EspnLogo> get copyWith => __$EspnLogoCopyWithImpl<_EspnLogo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnLogoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnLogo&&(identical(other.href, href) || other.href == href)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.alt, alt) || other.alt == alt)&&const DeepCollectionEquality().equals(other._rel, _rel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,href,width,height,alt,const DeepCollectionEquality().hash(_rel));

@override
String toString() {
  return 'EspnLogo(href: $href, width: $width, height: $height, alt: $alt, rel: $rel)';
}


}

/// @nodoc
abstract mixin class _$EspnLogoCopyWith<$Res> implements $EspnLogoCopyWith<$Res> {
  factory _$EspnLogoCopyWith(_EspnLogo value, $Res Function(_EspnLogo) _then) = __$EspnLogoCopyWithImpl;
@override @useResult
$Res call({
 String href, int width, int height, String alt, List<String> rel
});




}
/// @nodoc
class __$EspnLogoCopyWithImpl<$Res>
    implements _$EspnLogoCopyWith<$Res> {
  __$EspnLogoCopyWithImpl(this._self, this._then);

  final _EspnLogo _self;
  final $Res Function(_EspnLogo) _then;

/// Create a copy of EspnLogo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? href = null,Object? width = null,Object? height = null,Object? alt = null,Object? rel = null,}) {
  return _then(_EspnLogo(
href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,alt: null == alt ? _self.alt : alt // ignore: cast_nullable_to_non_nullable
as String,rel: null == rel ? _self._rel : rel // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$EspnScore {

 String get value; String get displayValue;
/// Create a copy of EspnScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnScoreCopyWith<EspnScore> get copyWith => _$EspnScoreCopyWithImpl<EspnScore>(this as EspnScore, _$identity);

  /// Serializes this EspnScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnScore&&(identical(other.value, value) || other.value == value)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,displayValue);

@override
String toString() {
  return 'EspnScore(value: $value, displayValue: $displayValue)';
}


}

/// @nodoc
abstract mixin class $EspnScoreCopyWith<$Res>  {
  factory $EspnScoreCopyWith(EspnScore value, $Res Function(EspnScore) _then) = _$EspnScoreCopyWithImpl;
@useResult
$Res call({
 String value, String displayValue
});




}
/// @nodoc
class _$EspnScoreCopyWithImpl<$Res>
    implements $EspnScoreCopyWith<$Res> {
  _$EspnScoreCopyWithImpl(this._self, this._then);

  final EspnScore _self;
  final $Res Function(EspnScore) _then;

/// Create a copy of EspnScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? displayValue = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,displayValue: null == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnScore].
extension EspnScorePatterns on EspnScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnScore value)  $default,){
final _that = this;
switch (_that) {
case _EspnScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnScore value)?  $default,){
final _that = this;
switch (_that) {
case _EspnScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String displayValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnScore() when $default != null:
return $default(_that.value,_that.displayValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String displayValue)  $default,) {final _that = this;
switch (_that) {
case _EspnScore():
return $default(_that.value,_that.displayValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String displayValue)?  $default,) {final _that = this;
switch (_that) {
case _EspnScore() when $default != null:
return $default(_that.value,_that.displayValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnScore implements EspnScore {
  const _EspnScore({required this.value, required this.displayValue});
  factory _EspnScore.fromJson(Map<String, dynamic> json) => _$EspnScoreFromJson(json);

@override final  String value;
@override final  String displayValue;

/// Create a copy of EspnScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnScoreCopyWith<_EspnScore> get copyWith => __$EspnScoreCopyWithImpl<_EspnScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnScore&&(identical(other.value, value) || other.value == value)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,displayValue);

@override
String toString() {
  return 'EspnScore(value: $value, displayValue: $displayValue)';
}


}

/// @nodoc
abstract mixin class _$EspnScoreCopyWith<$Res> implements $EspnScoreCopyWith<$Res> {
  factory _$EspnScoreCopyWith(_EspnScore value, $Res Function(_EspnScore) _then) = __$EspnScoreCopyWithImpl;
@override @useResult
$Res call({
 String value, String displayValue
});




}
/// @nodoc
class __$EspnScoreCopyWithImpl<$Res>
    implements _$EspnScoreCopyWith<$Res> {
  __$EspnScoreCopyWithImpl(this._self, this._then);

  final _EspnScore _self;
  final $Res Function(_EspnScore) _then;

/// Create a copy of EspnScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? displayValue = null,}) {
  return _then(_EspnScore(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,displayValue: null == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EspnRecord {

 String get name; String get abbreviation; String get type; String get summary;
/// Create a copy of EspnRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnRecordCopyWith<EspnRecord> get copyWith => _$EspnRecordCopyWithImpl<EspnRecord>(this as EspnRecord, _$identity);

  /// Serializes this EspnRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnRecord&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.type, type) || other.type == type)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,abbreviation,type,summary);

@override
String toString() {
  return 'EspnRecord(name: $name, abbreviation: $abbreviation, type: $type, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $EspnRecordCopyWith<$Res>  {
  factory $EspnRecordCopyWith(EspnRecord value, $Res Function(EspnRecord) _then) = _$EspnRecordCopyWithImpl;
@useResult
$Res call({
 String name, String abbreviation, String type, String summary
});




}
/// @nodoc
class _$EspnRecordCopyWithImpl<$Res>
    implements $EspnRecordCopyWith<$Res> {
  _$EspnRecordCopyWithImpl(this._self, this._then);

  final EspnRecord _self;
  final $Res Function(EspnRecord) _then;

/// Create a copy of EspnRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? abbreviation = null,Object? type = null,Object? summary = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnRecord].
extension EspnRecordPatterns on EspnRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnRecord value)  $default,){
final _that = this;
switch (_that) {
case _EspnRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnRecord value)?  $default,){
final _that = this;
switch (_that) {
case _EspnRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String abbreviation,  String type,  String summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnRecord() when $default != null:
return $default(_that.name,_that.abbreviation,_that.type,_that.summary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String abbreviation,  String type,  String summary)  $default,) {final _that = this;
switch (_that) {
case _EspnRecord():
return $default(_that.name,_that.abbreviation,_that.type,_that.summary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String abbreviation,  String type,  String summary)?  $default,) {final _that = this;
switch (_that) {
case _EspnRecord() when $default != null:
return $default(_that.name,_that.abbreviation,_that.type,_that.summary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnRecord implements EspnRecord {
  const _EspnRecord({required this.name, required this.abbreviation, required this.type, required this.summary});
  factory _EspnRecord.fromJson(Map<String, dynamic> json) => _$EspnRecordFromJson(json);

@override final  String name;
@override final  String abbreviation;
@override final  String type;
@override final  String summary;

/// Create a copy of EspnRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnRecordCopyWith<_EspnRecord> get copyWith => __$EspnRecordCopyWithImpl<_EspnRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnRecord&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.type, type) || other.type == type)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,abbreviation,type,summary);

@override
String toString() {
  return 'EspnRecord(name: $name, abbreviation: $abbreviation, type: $type, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$EspnRecordCopyWith<$Res> implements $EspnRecordCopyWith<$Res> {
  factory _$EspnRecordCopyWith(_EspnRecord value, $Res Function(_EspnRecord) _then) = __$EspnRecordCopyWithImpl;
@override @useResult
$Res call({
 String name, String abbreviation, String type, String summary
});




}
/// @nodoc
class __$EspnRecordCopyWithImpl<$Res>
    implements _$EspnRecordCopyWith<$Res> {
  __$EspnRecordCopyWithImpl(this._self, this._then);

  final _EspnRecord _self;
  final $Res Function(_EspnRecord) _then;

/// Create a copy of EspnRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? abbreviation = null,Object? type = null,Object? summary = null,}) {
  return _then(_EspnRecord(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EspnWinner {

 String get value; String get displayValue;
/// Create a copy of EspnWinner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnWinnerCopyWith<EspnWinner> get copyWith => _$EspnWinnerCopyWithImpl<EspnWinner>(this as EspnWinner, _$identity);

  /// Serializes this EspnWinner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnWinner&&(identical(other.value, value) || other.value == value)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,displayValue);

@override
String toString() {
  return 'EspnWinner(value: $value, displayValue: $displayValue)';
}


}

/// @nodoc
abstract mixin class $EspnWinnerCopyWith<$Res>  {
  factory $EspnWinnerCopyWith(EspnWinner value, $Res Function(EspnWinner) _then) = _$EspnWinnerCopyWithImpl;
@useResult
$Res call({
 String value, String displayValue
});




}
/// @nodoc
class _$EspnWinnerCopyWithImpl<$Res>
    implements $EspnWinnerCopyWith<$Res> {
  _$EspnWinnerCopyWithImpl(this._self, this._then);

  final EspnWinner _self;
  final $Res Function(EspnWinner) _then;

/// Create a copy of EspnWinner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? displayValue = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,displayValue: null == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnWinner].
extension EspnWinnerPatterns on EspnWinner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnWinner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnWinner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnWinner value)  $default,){
final _that = this;
switch (_that) {
case _EspnWinner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnWinner value)?  $default,){
final _that = this;
switch (_that) {
case _EspnWinner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String displayValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnWinner() when $default != null:
return $default(_that.value,_that.displayValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String displayValue)  $default,) {final _that = this;
switch (_that) {
case _EspnWinner():
return $default(_that.value,_that.displayValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String displayValue)?  $default,) {final _that = this;
switch (_that) {
case _EspnWinner() when $default != null:
return $default(_that.value,_that.displayValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnWinner implements EspnWinner {
  const _EspnWinner({required this.value, required this.displayValue});
  factory _EspnWinner.fromJson(Map<String, dynamic> json) => _$EspnWinnerFromJson(json);

@override final  String value;
@override final  String displayValue;

/// Create a copy of EspnWinner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnWinnerCopyWith<_EspnWinner> get copyWith => __$EspnWinnerCopyWithImpl<_EspnWinner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnWinnerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnWinner&&(identical(other.value, value) || other.value == value)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,displayValue);

@override
String toString() {
  return 'EspnWinner(value: $value, displayValue: $displayValue)';
}


}

/// @nodoc
abstract mixin class _$EspnWinnerCopyWith<$Res> implements $EspnWinnerCopyWith<$Res> {
  factory _$EspnWinnerCopyWith(_EspnWinner value, $Res Function(_EspnWinner) _then) = __$EspnWinnerCopyWithImpl;
@override @useResult
$Res call({
 String value, String displayValue
});




}
/// @nodoc
class __$EspnWinnerCopyWithImpl<$Res>
    implements _$EspnWinnerCopyWith<$Res> {
  __$EspnWinnerCopyWithImpl(this._self, this._then);

  final _EspnWinner _self;
  final $Res Function(_EspnWinner) _then;

/// Create a copy of EspnWinner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? displayValue = null,}) {
  return _then(_EspnWinner(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,displayValue: null == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EspnStatistic {

 String get label; String get value;
/// Create a copy of EspnStatistic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnStatisticCopyWith<EspnStatistic> get copyWith => _$EspnStatisticCopyWithImpl<EspnStatistic>(this as EspnStatistic, _$identity);

  /// Serializes this EspnStatistic to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnStatistic&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,value);

@override
String toString() {
  return 'EspnStatistic(label: $label, value: $value)';
}


}

/// @nodoc
abstract mixin class $EspnStatisticCopyWith<$Res>  {
  factory $EspnStatisticCopyWith(EspnStatistic value, $Res Function(EspnStatistic) _then) = _$EspnStatisticCopyWithImpl;
@useResult
$Res call({
 String label, String value
});




}
/// @nodoc
class _$EspnStatisticCopyWithImpl<$Res>
    implements $EspnStatisticCopyWith<$Res> {
  _$EspnStatisticCopyWithImpl(this._self, this._then);

  final EspnStatistic _self;
  final $Res Function(EspnStatistic) _then;

/// Create a copy of EspnStatistic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? value = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnStatistic].
extension EspnStatisticPatterns on EspnStatistic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnStatistic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnStatistic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnStatistic value)  $default,){
final _that = this;
switch (_that) {
case _EspnStatistic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnStatistic value)?  $default,){
final _that = this;
switch (_that) {
case _EspnStatistic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnStatistic() when $default != null:
return $default(_that.label,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String value)  $default,) {final _that = this;
switch (_that) {
case _EspnStatistic():
return $default(_that.label,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String value)?  $default,) {final _that = this;
switch (_that) {
case _EspnStatistic() when $default != null:
return $default(_that.label,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnStatistic implements EspnStatistic {
  const _EspnStatistic({required this.label, required this.value});
  factory _EspnStatistic.fromJson(Map<String, dynamic> json) => _$EspnStatisticFromJson(json);

@override final  String label;
@override final  String value;

/// Create a copy of EspnStatistic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnStatisticCopyWith<_EspnStatistic> get copyWith => __$EspnStatisticCopyWithImpl<_EspnStatistic>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnStatisticToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnStatistic&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,value);

@override
String toString() {
  return 'EspnStatistic(label: $label, value: $value)';
}


}

/// @nodoc
abstract mixin class _$EspnStatisticCopyWith<$Res> implements $EspnStatisticCopyWith<$Res> {
  factory _$EspnStatisticCopyWith(_EspnStatistic value, $Res Function(_EspnStatistic) _then) = __$EspnStatisticCopyWithImpl;
@override @useResult
$Res call({
 String label, String value
});




}
/// @nodoc
class __$EspnStatisticCopyWithImpl<$Res>
    implements _$EspnStatisticCopyWith<$Res> {
  __$EspnStatisticCopyWithImpl(this._self, this._then);

  final _EspnStatistic _self;
  final $Res Function(_EspnStatistic) _then;

/// Create a copy of EspnStatistic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? value = null,}) {
  return _then(_EspnStatistic(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EspnLeader {

 String get displayName; String get shortDisplayName; String get abbreviation; EspnLeaderLeaders get leaders;
/// Create a copy of EspnLeader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnLeaderCopyWith<EspnLeader> get copyWith => _$EspnLeaderCopyWithImpl<EspnLeader>(this as EspnLeader, _$identity);

  /// Serializes this EspnLeader to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnLeader&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.shortDisplayName, shortDisplayName) || other.shortDisplayName == shortDisplayName)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.leaders, leaders) || other.leaders == leaders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,shortDisplayName,abbreviation,leaders);

@override
String toString() {
  return 'EspnLeader(displayName: $displayName, shortDisplayName: $shortDisplayName, abbreviation: $abbreviation, leaders: $leaders)';
}


}

/// @nodoc
abstract mixin class $EspnLeaderCopyWith<$Res>  {
  factory $EspnLeaderCopyWith(EspnLeader value, $Res Function(EspnLeader) _then) = _$EspnLeaderCopyWithImpl;
@useResult
$Res call({
 String displayName, String shortDisplayName, String abbreviation, EspnLeaderLeaders leaders
});


$EspnLeaderLeadersCopyWith<$Res> get leaders;

}
/// @nodoc
class _$EspnLeaderCopyWithImpl<$Res>
    implements $EspnLeaderCopyWith<$Res> {
  _$EspnLeaderCopyWithImpl(this._self, this._then);

  final EspnLeader _self;
  final $Res Function(EspnLeader) _then;

/// Create a copy of EspnLeader
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? shortDisplayName = null,Object? abbreviation = null,Object? leaders = null,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,shortDisplayName: null == shortDisplayName ? _self.shortDisplayName : shortDisplayName // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,leaders: null == leaders ? _self.leaders : leaders // ignore: cast_nullable_to_non_nullable
as EspnLeaderLeaders,
  ));
}
/// Create a copy of EspnLeader
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnLeaderLeadersCopyWith<$Res> get leaders {
  
  return $EspnLeaderLeadersCopyWith<$Res>(_self.leaders, (value) {
    return _then(_self.copyWith(leaders: value));
  });
}
}


/// Adds pattern-matching-related methods to [EspnLeader].
extension EspnLeaderPatterns on EspnLeader {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnLeader value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnLeader() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnLeader value)  $default,){
final _that = this;
switch (_that) {
case _EspnLeader():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnLeader value)?  $default,){
final _that = this;
switch (_that) {
case _EspnLeader() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String shortDisplayName,  String abbreviation,  EspnLeaderLeaders leaders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnLeader() when $default != null:
return $default(_that.displayName,_that.shortDisplayName,_that.abbreviation,_that.leaders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String shortDisplayName,  String abbreviation,  EspnLeaderLeaders leaders)  $default,) {final _that = this;
switch (_that) {
case _EspnLeader():
return $default(_that.displayName,_that.shortDisplayName,_that.abbreviation,_that.leaders);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String shortDisplayName,  String abbreviation,  EspnLeaderLeaders leaders)?  $default,) {final _that = this;
switch (_that) {
case _EspnLeader() when $default != null:
return $default(_that.displayName,_that.shortDisplayName,_that.abbreviation,_that.leaders);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnLeader implements EspnLeader {
  const _EspnLeader({required this.displayName, required this.shortDisplayName, required this.abbreviation, required this.leaders});
  factory _EspnLeader.fromJson(Map<String, dynamic> json) => _$EspnLeaderFromJson(json);

@override final  String displayName;
@override final  String shortDisplayName;
@override final  String abbreviation;
@override final  EspnLeaderLeaders leaders;

/// Create a copy of EspnLeader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnLeaderCopyWith<_EspnLeader> get copyWith => __$EspnLeaderCopyWithImpl<_EspnLeader>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnLeaderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnLeader&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.shortDisplayName, shortDisplayName) || other.shortDisplayName == shortDisplayName)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.leaders, leaders) || other.leaders == leaders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,shortDisplayName,abbreviation,leaders);

@override
String toString() {
  return 'EspnLeader(displayName: $displayName, shortDisplayName: $shortDisplayName, abbreviation: $abbreviation, leaders: $leaders)';
}


}

/// @nodoc
abstract mixin class _$EspnLeaderCopyWith<$Res> implements $EspnLeaderCopyWith<$Res> {
  factory _$EspnLeaderCopyWith(_EspnLeader value, $Res Function(_EspnLeader) _then) = __$EspnLeaderCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String shortDisplayName, String abbreviation, EspnLeaderLeaders leaders
});


@override $EspnLeaderLeadersCopyWith<$Res> get leaders;

}
/// @nodoc
class __$EspnLeaderCopyWithImpl<$Res>
    implements _$EspnLeaderCopyWith<$Res> {
  __$EspnLeaderCopyWithImpl(this._self, this._then);

  final _EspnLeader _self;
  final $Res Function(_EspnLeader) _then;

/// Create a copy of EspnLeader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? shortDisplayName = null,Object? abbreviation = null,Object? leaders = null,}) {
  return _then(_EspnLeader(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,shortDisplayName: null == shortDisplayName ? _self.shortDisplayName : shortDisplayName // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,leaders: null == leaders ? _self.leaders : leaders // ignore: cast_nullable_to_non_nullable
as EspnLeaderLeaders,
  ));
}

/// Create a copy of EspnLeader
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnLeaderLeadersCopyWith<$Res> get leaders {
  
  return $EspnLeaderLeadersCopyWith<$Res>(_self.leaders, (value) {
    return _then(_self.copyWith(leaders: value));
  });
}
}


/// @nodoc
mixin _$EspnLeaderLeaders {

 String get value; String get displayValue;
/// Create a copy of EspnLeaderLeaders
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnLeaderLeadersCopyWith<EspnLeaderLeaders> get copyWith => _$EspnLeaderLeadersCopyWithImpl<EspnLeaderLeaders>(this as EspnLeaderLeaders, _$identity);

  /// Serializes this EspnLeaderLeaders to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnLeaderLeaders&&(identical(other.value, value) || other.value == value)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,displayValue);

@override
String toString() {
  return 'EspnLeaderLeaders(value: $value, displayValue: $displayValue)';
}


}

/// @nodoc
abstract mixin class $EspnLeaderLeadersCopyWith<$Res>  {
  factory $EspnLeaderLeadersCopyWith(EspnLeaderLeaders value, $Res Function(EspnLeaderLeaders) _then) = _$EspnLeaderLeadersCopyWithImpl;
@useResult
$Res call({
 String value, String displayValue
});




}
/// @nodoc
class _$EspnLeaderLeadersCopyWithImpl<$Res>
    implements $EspnLeaderLeadersCopyWith<$Res> {
  _$EspnLeaderLeadersCopyWithImpl(this._self, this._then);

  final EspnLeaderLeaders _self;
  final $Res Function(EspnLeaderLeaders) _then;

/// Create a copy of EspnLeaderLeaders
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? displayValue = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,displayValue: null == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnLeaderLeaders].
extension EspnLeaderLeadersPatterns on EspnLeaderLeaders {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnLeaderLeaders value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnLeaderLeaders() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnLeaderLeaders value)  $default,){
final _that = this;
switch (_that) {
case _EspnLeaderLeaders():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnLeaderLeaders value)?  $default,){
final _that = this;
switch (_that) {
case _EspnLeaderLeaders() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String displayValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnLeaderLeaders() when $default != null:
return $default(_that.value,_that.displayValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String displayValue)  $default,) {final _that = this;
switch (_that) {
case _EspnLeaderLeaders():
return $default(_that.value,_that.displayValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String displayValue)?  $default,) {final _that = this;
switch (_that) {
case _EspnLeaderLeaders() when $default != null:
return $default(_that.value,_that.displayValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnLeaderLeaders implements EspnLeaderLeaders {
  const _EspnLeaderLeaders({required this.value, required this.displayValue});
  factory _EspnLeaderLeaders.fromJson(Map<String, dynamic> json) => _$EspnLeaderLeadersFromJson(json);

@override final  String value;
@override final  String displayValue;

/// Create a copy of EspnLeaderLeaders
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnLeaderLeadersCopyWith<_EspnLeaderLeaders> get copyWith => __$EspnLeaderLeadersCopyWithImpl<_EspnLeaderLeaders>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnLeaderLeadersToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnLeaderLeaders&&(identical(other.value, value) || other.value == value)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,displayValue);

@override
String toString() {
  return 'EspnLeaderLeaders(value: $value, displayValue: $displayValue)';
}


}

/// @nodoc
abstract mixin class _$EspnLeaderLeadersCopyWith<$Res> implements $EspnLeaderLeadersCopyWith<$Res> {
  factory _$EspnLeaderLeadersCopyWith(_EspnLeaderLeaders value, $Res Function(_EspnLeaderLeaders) _then) = __$EspnLeaderLeadersCopyWithImpl;
@override @useResult
$Res call({
 String value, String displayValue
});




}
/// @nodoc
class __$EspnLeaderLeadersCopyWithImpl<$Res>
    implements _$EspnLeaderLeadersCopyWith<$Res> {
  __$EspnLeaderLeadersCopyWithImpl(this._self, this._then);

  final _EspnLeaderLeaders _self;
  final $Res Function(_EspnLeaderLeaders) _then;

/// Create a copy of EspnLeaderLeaders
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? displayValue = null,}) {
  return _then(_EspnLeaderLeaders(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,displayValue: null == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EspnStatus {

 int get clock; String get displayClock; int get period; EspnType get type; bool get completed; String get description; String get detail; String get shortDetail;
/// Create a copy of EspnStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnStatusCopyWith<EspnStatus> get copyWith => _$EspnStatusCopyWithImpl<EspnStatus>(this as EspnStatus, _$identity);

  /// Serializes this EspnStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnStatus&&(identical(other.clock, clock) || other.clock == clock)&&(identical(other.displayClock, displayClock) || other.displayClock == displayClock)&&(identical(other.period, period) || other.period == period)&&(identical(other.type, type) || other.type == type)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.description, description) || other.description == description)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.shortDetail, shortDetail) || other.shortDetail == shortDetail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clock,displayClock,period,type,completed,description,detail,shortDetail);

@override
String toString() {
  return 'EspnStatus(clock: $clock, displayClock: $displayClock, period: $period, type: $type, completed: $completed, description: $description, detail: $detail, shortDetail: $shortDetail)';
}


}

/// @nodoc
abstract mixin class $EspnStatusCopyWith<$Res>  {
  factory $EspnStatusCopyWith(EspnStatus value, $Res Function(EspnStatus) _then) = _$EspnStatusCopyWithImpl;
@useResult
$Res call({
 int clock, String displayClock, int period, EspnType type, bool completed, String description, String detail, String shortDetail
});


$EspnTypeCopyWith<$Res> get type;

}
/// @nodoc
class _$EspnStatusCopyWithImpl<$Res>
    implements $EspnStatusCopyWith<$Res> {
  _$EspnStatusCopyWithImpl(this._self, this._then);

  final EspnStatus _self;
  final $Res Function(EspnStatus) _then;

/// Create a copy of EspnStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clock = null,Object? displayClock = null,Object? period = null,Object? type = null,Object? completed = null,Object? description = null,Object? detail = null,Object? shortDetail = null,}) {
  return _then(_self.copyWith(
clock: null == clock ? _self.clock : clock // ignore: cast_nullable_to_non_nullable
as int,displayClock: null == displayClock ? _self.displayClock : displayClock // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EspnType,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,shortDetail: null == shortDetail ? _self.shortDetail : shortDetail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of EspnStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnTypeCopyWith<$Res> get type {
  
  return $EspnTypeCopyWith<$Res>(_self.type, (value) {
    return _then(_self.copyWith(type: value));
  });
}
}


/// Adds pattern-matching-related methods to [EspnStatus].
extension EspnStatusPatterns on EspnStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnStatus value)  $default,){
final _that = this;
switch (_that) {
case _EspnStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnStatus value)?  $default,){
final _that = this;
switch (_that) {
case _EspnStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int clock,  String displayClock,  int period,  EspnType type,  bool completed,  String description,  String detail,  String shortDetail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnStatus() when $default != null:
return $default(_that.clock,_that.displayClock,_that.period,_that.type,_that.completed,_that.description,_that.detail,_that.shortDetail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int clock,  String displayClock,  int period,  EspnType type,  bool completed,  String description,  String detail,  String shortDetail)  $default,) {final _that = this;
switch (_that) {
case _EspnStatus():
return $default(_that.clock,_that.displayClock,_that.period,_that.type,_that.completed,_that.description,_that.detail,_that.shortDetail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int clock,  String displayClock,  int period,  EspnType type,  bool completed,  String description,  String detail,  String shortDetail)?  $default,) {final _that = this;
switch (_that) {
case _EspnStatus() when $default != null:
return $default(_that.clock,_that.displayClock,_that.period,_that.type,_that.completed,_that.description,_that.detail,_that.shortDetail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnStatus implements EspnStatus {
  const _EspnStatus({required this.clock, required this.displayClock, required this.period, required this.type, required this.completed, required this.description, required this.detail, required this.shortDetail});
  factory _EspnStatus.fromJson(Map<String, dynamic> json) => _$EspnStatusFromJson(json);

@override final  int clock;
@override final  String displayClock;
@override final  int period;
@override final  EspnType type;
@override final  bool completed;
@override final  String description;
@override final  String detail;
@override final  String shortDetail;

/// Create a copy of EspnStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnStatusCopyWith<_EspnStatus> get copyWith => __$EspnStatusCopyWithImpl<_EspnStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnStatus&&(identical(other.clock, clock) || other.clock == clock)&&(identical(other.displayClock, displayClock) || other.displayClock == displayClock)&&(identical(other.period, period) || other.period == period)&&(identical(other.type, type) || other.type == type)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.description, description) || other.description == description)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.shortDetail, shortDetail) || other.shortDetail == shortDetail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clock,displayClock,period,type,completed,description,detail,shortDetail);

@override
String toString() {
  return 'EspnStatus(clock: $clock, displayClock: $displayClock, period: $period, type: $type, completed: $completed, description: $description, detail: $detail, shortDetail: $shortDetail)';
}


}

/// @nodoc
abstract mixin class _$EspnStatusCopyWith<$Res> implements $EspnStatusCopyWith<$Res> {
  factory _$EspnStatusCopyWith(_EspnStatus value, $Res Function(_EspnStatus) _then) = __$EspnStatusCopyWithImpl;
@override @useResult
$Res call({
 int clock, String displayClock, int period, EspnType type, bool completed, String description, String detail, String shortDetail
});


@override $EspnTypeCopyWith<$Res> get type;

}
/// @nodoc
class __$EspnStatusCopyWithImpl<$Res>
    implements _$EspnStatusCopyWith<$Res> {
  __$EspnStatusCopyWithImpl(this._self, this._then);

  final _EspnStatus _self;
  final $Res Function(_EspnStatus) _then;

/// Create a copy of EspnStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clock = null,Object? displayClock = null,Object? period = null,Object? type = null,Object? completed = null,Object? description = null,Object? detail = null,Object? shortDetail = null,}) {
  return _then(_EspnStatus(
clock: null == clock ? _self.clock : clock // ignore: cast_nullable_to_non_nullable
as int,displayClock: null == displayClock ? _self.displayClock : displayClock // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EspnType,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,shortDetail: null == shortDetail ? _self.shortDetail : shortDetail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of EspnStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnTypeCopyWith<$Res> get type {
  
  return $EspnTypeCopyWith<$Res>(_self.type, (value) {
    return _then(_self.copyWith(type: value));
  });
}
}


/// @nodoc
mixin _$EspnType {

 String get id; String get abbreviation;
/// Create a copy of EspnType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnTypeCopyWith<EspnType> get copyWith => _$EspnTypeCopyWithImpl<EspnType>(this as EspnType, _$identity);

  /// Serializes this EspnType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnType&&(identical(other.id, id) || other.id == id)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,abbreviation);

@override
String toString() {
  return 'EspnType(id: $id, abbreviation: $abbreviation)';
}


}

/// @nodoc
abstract mixin class $EspnTypeCopyWith<$Res>  {
  factory $EspnTypeCopyWith(EspnType value, $Res Function(EspnType) _then) = _$EspnTypeCopyWithImpl;
@useResult
$Res call({
 String id, String abbreviation
});




}
/// @nodoc
class _$EspnTypeCopyWithImpl<$Res>
    implements $EspnTypeCopyWith<$Res> {
  _$EspnTypeCopyWithImpl(this._self, this._then);

  final EspnType _self;
  final $Res Function(EspnType) _then;

/// Create a copy of EspnType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? abbreviation = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnType].
extension EspnTypePatterns on EspnType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnType value)  $default,){
final _that = this;
switch (_that) {
case _EspnType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnType value)?  $default,){
final _that = this;
switch (_that) {
case _EspnType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String abbreviation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnType() when $default != null:
return $default(_that.id,_that.abbreviation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String abbreviation)  $default,) {final _that = this;
switch (_that) {
case _EspnType():
return $default(_that.id,_that.abbreviation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String abbreviation)?  $default,) {final _that = this;
switch (_that) {
case _EspnType() when $default != null:
return $default(_that.id,_that.abbreviation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnType implements EspnType {
  const _EspnType({required this.id, required this.abbreviation});
  factory _EspnType.fromJson(Map<String, dynamic> json) => _$EspnTypeFromJson(json);

@override final  String id;
@override final  String abbreviation;

/// Create a copy of EspnType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnTypeCopyWith<_EspnType> get copyWith => __$EspnTypeCopyWithImpl<_EspnType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnType&&(identical(other.id, id) || other.id == id)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,abbreviation);

@override
String toString() {
  return 'EspnType(id: $id, abbreviation: $abbreviation)';
}


}

/// @nodoc
abstract mixin class _$EspnTypeCopyWith<$Res> implements $EspnTypeCopyWith<$Res> {
  factory _$EspnTypeCopyWith(_EspnType value, $Res Function(_EspnType) _then) = __$EspnTypeCopyWithImpl;
@override @useResult
$Res call({
 String id, String abbreviation
});




}
/// @nodoc
class __$EspnTypeCopyWithImpl<$Res>
    implements _$EspnTypeCopyWith<$Res> {
  __$EspnTypeCopyWithImpl(this._self, this._then);

  final _EspnType _self;
  final $Res Function(_EspnType) _then;

/// Create a copy of EspnType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? abbreviation = null,}) {
  return _then(_EspnType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EspnBroadcast {

 String get market; List<String> get names;
/// Create a copy of EspnBroadcast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnBroadcastCopyWith<EspnBroadcast> get copyWith => _$EspnBroadcastCopyWithImpl<EspnBroadcast>(this as EspnBroadcast, _$identity);

  /// Serializes this EspnBroadcast to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnBroadcast&&(identical(other.market, market) || other.market == market)&&const DeepCollectionEquality().equals(other.names, names));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,market,const DeepCollectionEquality().hash(names));

@override
String toString() {
  return 'EspnBroadcast(market: $market, names: $names)';
}


}

/// @nodoc
abstract mixin class $EspnBroadcastCopyWith<$Res>  {
  factory $EspnBroadcastCopyWith(EspnBroadcast value, $Res Function(EspnBroadcast) _then) = _$EspnBroadcastCopyWithImpl;
@useResult
$Res call({
 String market, List<String> names
});




}
/// @nodoc
class _$EspnBroadcastCopyWithImpl<$Res>
    implements $EspnBroadcastCopyWith<$Res> {
  _$EspnBroadcastCopyWithImpl(this._self, this._then);

  final EspnBroadcast _self;
  final $Res Function(EspnBroadcast) _then;

/// Create a copy of EspnBroadcast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? market = null,Object? names = null,}) {
  return _then(_self.copyWith(
market: null == market ? _self.market : market // ignore: cast_nullable_to_non_nullable
as String,names: null == names ? _self.names : names // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnBroadcast].
extension EspnBroadcastPatterns on EspnBroadcast {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnBroadcast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnBroadcast() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnBroadcast value)  $default,){
final _that = this;
switch (_that) {
case _EspnBroadcast():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnBroadcast value)?  $default,){
final _that = this;
switch (_that) {
case _EspnBroadcast() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String market,  List<String> names)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnBroadcast() when $default != null:
return $default(_that.market,_that.names);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String market,  List<String> names)  $default,) {final _that = this;
switch (_that) {
case _EspnBroadcast():
return $default(_that.market,_that.names);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String market,  List<String> names)?  $default,) {final _that = this;
switch (_that) {
case _EspnBroadcast() when $default != null:
return $default(_that.market,_that.names);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnBroadcast implements EspnBroadcast {
  const _EspnBroadcast({required this.market, required final  List<String> names}): _names = names;
  factory _EspnBroadcast.fromJson(Map<String, dynamic> json) => _$EspnBroadcastFromJson(json);

@override final  String market;
 final  List<String> _names;
@override List<String> get names {
  if (_names is EqualUnmodifiableListView) return _names;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_names);
}


/// Create a copy of EspnBroadcast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnBroadcastCopyWith<_EspnBroadcast> get copyWith => __$EspnBroadcastCopyWithImpl<_EspnBroadcast>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnBroadcastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnBroadcast&&(identical(other.market, market) || other.market == market)&&const DeepCollectionEquality().equals(other._names, _names));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,market,const DeepCollectionEquality().hash(_names));

@override
String toString() {
  return 'EspnBroadcast(market: $market, names: $names)';
}


}

/// @nodoc
abstract mixin class _$EspnBroadcastCopyWith<$Res> implements $EspnBroadcastCopyWith<$Res> {
  factory _$EspnBroadcastCopyWith(_EspnBroadcast value, $Res Function(_EspnBroadcast) _then) = __$EspnBroadcastCopyWithImpl;
@override @useResult
$Res call({
 String market, List<String> names
});




}
/// @nodoc
class __$EspnBroadcastCopyWithImpl<$Res>
    implements _$EspnBroadcastCopyWith<$Res> {
  __$EspnBroadcastCopyWithImpl(this._self, this._then);

  final _EspnBroadcast _self;
  final $Res Function(_EspnBroadcast) _then;

/// Create a copy of EspnBroadcast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? market = null,Object? names = null,}) {
  return _then(_EspnBroadcast(
market: null == market ? _self.market : market // ignore: cast_nullable_to_non_nullable
as String,names: null == names ? _self._names : names // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$EspnVenue {

 String get id; String get fullName; String get address; EspnCity get city; EspnState get state; String get zip; String get country; int get capacity; bool get grass; bool get indoor;
/// Create a copy of EspnVenue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnVenueCopyWith<EspnVenue> get copyWith => _$EspnVenueCopyWithImpl<EspnVenue>(this as EspnVenue, _$identity);

  /// Serializes this EspnVenue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnVenue&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.zip, zip) || other.zip == zip)&&(identical(other.country, country) || other.country == country)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.grass, grass) || other.grass == grass)&&(identical(other.indoor, indoor) || other.indoor == indoor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,address,city,state,zip,country,capacity,grass,indoor);

@override
String toString() {
  return 'EspnVenue(id: $id, fullName: $fullName, address: $address, city: $city, state: $state, zip: $zip, country: $country, capacity: $capacity, grass: $grass, indoor: $indoor)';
}


}

/// @nodoc
abstract mixin class $EspnVenueCopyWith<$Res>  {
  factory $EspnVenueCopyWith(EspnVenue value, $Res Function(EspnVenue) _then) = _$EspnVenueCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String address, EspnCity city, EspnState state, String zip, String country, int capacity, bool grass, bool indoor
});


$EspnCityCopyWith<$Res> get city;$EspnStateCopyWith<$Res> get state;

}
/// @nodoc
class _$EspnVenueCopyWithImpl<$Res>
    implements $EspnVenueCopyWith<$Res> {
  _$EspnVenueCopyWithImpl(this._self, this._then);

  final EspnVenue _self;
  final $Res Function(EspnVenue) _then;

/// Create a copy of EspnVenue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? address = null,Object? city = null,Object? state = null,Object? zip = null,Object? country = null,Object? capacity = null,Object? grass = null,Object? indoor = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as EspnCity,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as EspnState,zip: null == zip ? _self.zip : zip // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,grass: null == grass ? _self.grass : grass // ignore: cast_nullable_to_non_nullable
as bool,indoor: null == indoor ? _self.indoor : indoor // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of EspnVenue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnCityCopyWith<$Res> get city {
  
  return $EspnCityCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of EspnVenue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnStateCopyWith<$Res> get state {
  
  return $EspnStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}


/// Adds pattern-matching-related methods to [EspnVenue].
extension EspnVenuePatterns on EspnVenue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnVenue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnVenue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnVenue value)  $default,){
final _that = this;
switch (_that) {
case _EspnVenue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnVenue value)?  $default,){
final _that = this;
switch (_that) {
case _EspnVenue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String address,  EspnCity city,  EspnState state,  String zip,  String country,  int capacity,  bool grass,  bool indoor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnVenue() when $default != null:
return $default(_that.id,_that.fullName,_that.address,_that.city,_that.state,_that.zip,_that.country,_that.capacity,_that.grass,_that.indoor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String address,  EspnCity city,  EspnState state,  String zip,  String country,  int capacity,  bool grass,  bool indoor)  $default,) {final _that = this;
switch (_that) {
case _EspnVenue():
return $default(_that.id,_that.fullName,_that.address,_that.city,_that.state,_that.zip,_that.country,_that.capacity,_that.grass,_that.indoor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String address,  EspnCity city,  EspnState state,  String zip,  String country,  int capacity,  bool grass,  bool indoor)?  $default,) {final _that = this;
switch (_that) {
case _EspnVenue() when $default != null:
return $default(_that.id,_that.fullName,_that.address,_that.city,_that.state,_that.zip,_that.country,_that.capacity,_that.grass,_that.indoor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnVenue implements EspnVenue {
  const _EspnVenue({required this.id, required this.fullName, required this.address, required this.city, required this.state, required this.zip, required this.country, required this.capacity, required this.grass, required this.indoor});
  factory _EspnVenue.fromJson(Map<String, dynamic> json) => _$EspnVenueFromJson(json);

@override final  String id;
@override final  String fullName;
@override final  String address;
@override final  EspnCity city;
@override final  EspnState state;
@override final  String zip;
@override final  String country;
@override final  int capacity;
@override final  bool grass;
@override final  bool indoor;

/// Create a copy of EspnVenue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnVenueCopyWith<_EspnVenue> get copyWith => __$EspnVenueCopyWithImpl<_EspnVenue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnVenueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnVenue&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.zip, zip) || other.zip == zip)&&(identical(other.country, country) || other.country == country)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.grass, grass) || other.grass == grass)&&(identical(other.indoor, indoor) || other.indoor == indoor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,address,city,state,zip,country,capacity,grass,indoor);

@override
String toString() {
  return 'EspnVenue(id: $id, fullName: $fullName, address: $address, city: $city, state: $state, zip: $zip, country: $country, capacity: $capacity, grass: $grass, indoor: $indoor)';
}


}

/// @nodoc
abstract mixin class _$EspnVenueCopyWith<$Res> implements $EspnVenueCopyWith<$Res> {
  factory _$EspnVenueCopyWith(_EspnVenue value, $Res Function(_EspnVenue) _then) = __$EspnVenueCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String address, EspnCity city, EspnState state, String zip, String country, int capacity, bool grass, bool indoor
});


@override $EspnCityCopyWith<$Res> get city;@override $EspnStateCopyWith<$Res> get state;

}
/// @nodoc
class __$EspnVenueCopyWithImpl<$Res>
    implements _$EspnVenueCopyWith<$Res> {
  __$EspnVenueCopyWithImpl(this._self, this._then);

  final _EspnVenue _self;
  final $Res Function(_EspnVenue) _then;

/// Create a copy of EspnVenue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? address = null,Object? city = null,Object? state = null,Object? zip = null,Object? country = null,Object? capacity = null,Object? grass = null,Object? indoor = null,}) {
  return _then(_EspnVenue(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as EspnCity,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as EspnState,zip: null == zip ? _self.zip : zip // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,grass: null == grass ? _self.grass : grass // ignore: cast_nullable_to_non_nullable
as bool,indoor: null == indoor ? _self.indoor : indoor // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of EspnVenue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnCityCopyWith<$Res> get city {
  
  return $EspnCityCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of EspnVenue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnStateCopyWith<$Res> get state {
  
  return $EspnStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}


/// @nodoc
mixin _$EspnCity {

 String get id; String get name;
/// Create a copy of EspnCity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnCityCopyWith<EspnCity> get copyWith => _$EspnCityCopyWithImpl<EspnCity>(this as EspnCity, _$identity);

  /// Serializes this EspnCity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnCity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'EspnCity(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $EspnCityCopyWith<$Res>  {
  factory $EspnCityCopyWith(EspnCity value, $Res Function(EspnCity) _then) = _$EspnCityCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$EspnCityCopyWithImpl<$Res>
    implements $EspnCityCopyWith<$Res> {
  _$EspnCityCopyWithImpl(this._self, this._then);

  final EspnCity _self;
  final $Res Function(EspnCity) _then;

/// Create a copy of EspnCity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnCity].
extension EspnCityPatterns on EspnCity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnCity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnCity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnCity value)  $default,){
final _that = this;
switch (_that) {
case _EspnCity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnCity value)?  $default,){
final _that = this;
switch (_that) {
case _EspnCity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnCity() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _EspnCity():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _EspnCity() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnCity implements EspnCity {
  const _EspnCity({required this.id, required this.name});
  factory _EspnCity.fromJson(Map<String, dynamic> json) => _$EspnCityFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of EspnCity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnCityCopyWith<_EspnCity> get copyWith => __$EspnCityCopyWithImpl<_EspnCity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnCityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnCity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'EspnCity(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$EspnCityCopyWith<$Res> implements $EspnCityCopyWith<$Res> {
  factory _$EspnCityCopyWith(_EspnCity value, $Res Function(_EspnCity) _then) = __$EspnCityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$EspnCityCopyWithImpl<$Res>
    implements _$EspnCityCopyWith<$Res> {
  __$EspnCityCopyWithImpl(this._self, this._then);

  final _EspnCity _self;
  final $Res Function(_EspnCity) _then;

/// Create a copy of EspnCity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_EspnCity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EspnState {

 String get id; String get name; String get abbreviation;
/// Create a copy of EspnState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnStateCopyWith<EspnState> get copyWith => _$EspnStateCopyWithImpl<EspnState>(this as EspnState, _$identity);

  /// Serializes this EspnState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnState&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,abbreviation);

@override
String toString() {
  return 'EspnState(id: $id, name: $name, abbreviation: $abbreviation)';
}


}

/// @nodoc
abstract mixin class $EspnStateCopyWith<$Res>  {
  factory $EspnStateCopyWith(EspnState value, $Res Function(EspnState) _then) = _$EspnStateCopyWithImpl;
@useResult
$Res call({
 String id, String name, String abbreviation
});




}
/// @nodoc
class _$EspnStateCopyWithImpl<$Res>
    implements $EspnStateCopyWith<$Res> {
  _$EspnStateCopyWithImpl(this._self, this._then);

  final EspnState _self;
  final $Res Function(EspnState) _then;

/// Create a copy of EspnState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? abbreviation = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnState].
extension EspnStatePatterns on EspnState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnState value)  $default,){
final _that = this;
switch (_that) {
case _EspnState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnState value)?  $default,){
final _that = this;
switch (_that) {
case _EspnState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String abbreviation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnState() when $default != null:
return $default(_that.id,_that.name,_that.abbreviation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String abbreviation)  $default,) {final _that = this;
switch (_that) {
case _EspnState():
return $default(_that.id,_that.name,_that.abbreviation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String abbreviation)?  $default,) {final _that = this;
switch (_that) {
case _EspnState() when $default != null:
return $default(_that.id,_that.name,_that.abbreviation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnState implements EspnState {
  const _EspnState({required this.id, required this.name, required this.abbreviation});
  factory _EspnState.fromJson(Map<String, dynamic> json) => _$EspnStateFromJson(json);

@override final  String id;
@override final  String name;
@override final  String abbreviation;

/// Create a copy of EspnState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnStateCopyWith<_EspnState> get copyWith => __$EspnStateCopyWithImpl<_EspnState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnState&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,abbreviation);

@override
String toString() {
  return 'EspnState(id: $id, name: $name, abbreviation: $abbreviation)';
}


}

/// @nodoc
abstract mixin class _$EspnStateCopyWith<$Res> implements $EspnStateCopyWith<$Res> {
  factory _$EspnStateCopyWith(_EspnState value, $Res Function(_EspnState) _then) = __$EspnStateCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String abbreviation
});




}
/// @nodoc
class __$EspnStateCopyWithImpl<$Res>
    implements _$EspnStateCopyWith<$Res> {
  __$EspnStateCopyWithImpl(this._self, this._then);

  final _EspnState _self;
  final $Res Function(_EspnState) _then;

/// Create a copy of EspnState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? abbreviation = null,}) {
  return _then(_EspnState(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EspnStartDate {

 String get value; String get displayValue;
/// Create a copy of EspnStartDate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnStartDateCopyWith<EspnStartDate> get copyWith => _$EspnStartDateCopyWithImpl<EspnStartDate>(this as EspnStartDate, _$identity);

  /// Serializes this EspnStartDate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnStartDate&&(identical(other.value, value) || other.value == value)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,displayValue);

@override
String toString() {
  return 'EspnStartDate(value: $value, displayValue: $displayValue)';
}


}

/// @nodoc
abstract mixin class $EspnStartDateCopyWith<$Res>  {
  factory $EspnStartDateCopyWith(EspnStartDate value, $Res Function(EspnStartDate) _then) = _$EspnStartDateCopyWithImpl;
@useResult
$Res call({
 String value, String displayValue
});




}
/// @nodoc
class _$EspnStartDateCopyWithImpl<$Res>
    implements $EspnStartDateCopyWith<$Res> {
  _$EspnStartDateCopyWithImpl(this._self, this._then);

  final EspnStartDate _self;
  final $Res Function(EspnStartDate) _then;

/// Create a copy of EspnStartDate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? displayValue = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,displayValue: null == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnStartDate].
extension EspnStartDatePatterns on EspnStartDate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnStartDate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnStartDate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnStartDate value)  $default,){
final _that = this;
switch (_that) {
case _EspnStartDate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnStartDate value)?  $default,){
final _that = this;
switch (_that) {
case _EspnStartDate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String displayValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnStartDate() when $default != null:
return $default(_that.value,_that.displayValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String displayValue)  $default,) {final _that = this;
switch (_that) {
case _EspnStartDate():
return $default(_that.value,_that.displayValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String displayValue)?  $default,) {final _that = this;
switch (_that) {
case _EspnStartDate() when $default != null:
return $default(_that.value,_that.displayValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnStartDate implements EspnStartDate {
  const _EspnStartDate({required this.value, required this.displayValue});
  factory _EspnStartDate.fromJson(Map<String, dynamic> json) => _$EspnStartDateFromJson(json);

@override final  String value;
@override final  String displayValue;

/// Create a copy of EspnStartDate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnStartDateCopyWith<_EspnStartDate> get copyWith => __$EspnStartDateCopyWithImpl<_EspnStartDate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnStartDateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnStartDate&&(identical(other.value, value) || other.value == value)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,displayValue);

@override
String toString() {
  return 'EspnStartDate(value: $value, displayValue: $displayValue)';
}


}

/// @nodoc
abstract mixin class _$EspnStartDateCopyWith<$Res> implements $EspnStartDateCopyWith<$Res> {
  factory _$EspnStartDateCopyWith(_EspnStartDate value, $Res Function(_EspnStartDate) _then) = __$EspnStartDateCopyWithImpl;
@override @useResult
$Res call({
 String value, String displayValue
});




}
/// @nodoc
class __$EspnStartDateCopyWithImpl<$Res>
    implements _$EspnStartDateCopyWith<$Res> {
  __$EspnStartDateCopyWithImpl(this._self, this._then);

  final _EspnStartDate _self;
  final $Res Function(_EspnStartDate) _then;

/// Create a copy of EspnStartDate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? displayValue = null,}) {
  return _then(_EspnStartDate(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,displayValue: null == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EspnWeather {

 int get displayValue; int get highTemperature; String get conditionId; String get link;
/// Create a copy of EspnWeather
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnWeatherCopyWith<EspnWeather> get copyWith => _$EspnWeatherCopyWithImpl<EspnWeather>(this as EspnWeather, _$identity);

  /// Serializes this EspnWeather to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnWeather&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue)&&(identical(other.highTemperature, highTemperature) || other.highTemperature == highTemperature)&&(identical(other.conditionId, conditionId) || other.conditionId == conditionId)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayValue,highTemperature,conditionId,link);

@override
String toString() {
  return 'EspnWeather(displayValue: $displayValue, highTemperature: $highTemperature, conditionId: $conditionId, link: $link)';
}


}

/// @nodoc
abstract mixin class $EspnWeatherCopyWith<$Res>  {
  factory $EspnWeatherCopyWith(EspnWeather value, $Res Function(EspnWeather) _then) = _$EspnWeatherCopyWithImpl;
@useResult
$Res call({
 int displayValue, int highTemperature, String conditionId, String link
});




}
/// @nodoc
class _$EspnWeatherCopyWithImpl<$Res>
    implements $EspnWeatherCopyWith<$Res> {
  _$EspnWeatherCopyWithImpl(this._self, this._then);

  final EspnWeather _self;
  final $Res Function(EspnWeather) _then;

/// Create a copy of EspnWeather
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayValue = null,Object? highTemperature = null,Object? conditionId = null,Object? link = null,}) {
  return _then(_self.copyWith(
displayValue: null == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as int,highTemperature: null == highTemperature ? _self.highTemperature : highTemperature // ignore: cast_nullable_to_non_nullable
as int,conditionId: null == conditionId ? _self.conditionId : conditionId // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnWeather].
extension EspnWeatherPatterns on EspnWeather {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnWeather value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnWeather() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnWeather value)  $default,){
final _that = this;
switch (_that) {
case _EspnWeather():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnWeather value)?  $default,){
final _that = this;
switch (_that) {
case _EspnWeather() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int displayValue,  int highTemperature,  String conditionId,  String link)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnWeather() when $default != null:
return $default(_that.displayValue,_that.highTemperature,_that.conditionId,_that.link);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int displayValue,  int highTemperature,  String conditionId,  String link)  $default,) {final _that = this;
switch (_that) {
case _EspnWeather():
return $default(_that.displayValue,_that.highTemperature,_that.conditionId,_that.link);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int displayValue,  int highTemperature,  String conditionId,  String link)?  $default,) {final _that = this;
switch (_that) {
case _EspnWeather() when $default != null:
return $default(_that.displayValue,_that.highTemperature,_that.conditionId,_that.link);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnWeather implements EspnWeather {
  const _EspnWeather({required this.displayValue, required this.highTemperature, required this.conditionId, required this.link});
  factory _EspnWeather.fromJson(Map<String, dynamic> json) => _$EspnWeatherFromJson(json);

@override final  int displayValue;
@override final  int highTemperature;
@override final  String conditionId;
@override final  String link;

/// Create a copy of EspnWeather
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnWeatherCopyWith<_EspnWeather> get copyWith => __$EspnWeatherCopyWithImpl<_EspnWeather>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnWeatherToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnWeather&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue)&&(identical(other.highTemperature, highTemperature) || other.highTemperature == highTemperature)&&(identical(other.conditionId, conditionId) || other.conditionId == conditionId)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayValue,highTemperature,conditionId,link);

@override
String toString() {
  return 'EspnWeather(displayValue: $displayValue, highTemperature: $highTemperature, conditionId: $conditionId, link: $link)';
}


}

/// @nodoc
abstract mixin class _$EspnWeatherCopyWith<$Res> implements $EspnWeatherCopyWith<$Res> {
  factory _$EspnWeatherCopyWith(_EspnWeather value, $Res Function(_EspnWeather) _then) = __$EspnWeatherCopyWithImpl;
@override @useResult
$Res call({
 int displayValue, int highTemperature, String conditionId, String link
});




}
/// @nodoc
class __$EspnWeatherCopyWithImpl<$Res>
    implements _$EspnWeatherCopyWith<$Res> {
  __$EspnWeatherCopyWithImpl(this._self, this._then);

  final _EspnWeather _self;
  final $Res Function(_EspnWeather) _then;

/// Create a copy of EspnWeather
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayValue = null,Object? highTemperature = null,Object? conditionId = null,Object? link = null,}) {
  return _then(_EspnWeather(
displayValue: null == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as int,highTemperature: null == highTemperature ? _self.highTemperature : highTemperature // ignore: cast_nullable_to_non_nullable
as int,conditionId: null == conditionId ? _self.conditionId : conditionId // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EspnReferee {

 String get id; String get fullName; String get displayName; String get shortName; String get homeAway;
/// Create a copy of EspnReferee
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnRefereeCopyWith<EspnReferee> get copyWith => _$EspnRefereeCopyWithImpl<EspnReferee>(this as EspnReferee, _$identity);

  /// Serializes this EspnReferee to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnReferee&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.shortName, shortName) || other.shortName == shortName)&&(identical(other.homeAway, homeAway) || other.homeAway == homeAway));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,displayName,shortName,homeAway);

@override
String toString() {
  return 'EspnReferee(id: $id, fullName: $fullName, displayName: $displayName, shortName: $shortName, homeAway: $homeAway)';
}


}

/// @nodoc
abstract mixin class $EspnRefereeCopyWith<$Res>  {
  factory $EspnRefereeCopyWith(EspnReferee value, $Res Function(EspnReferee) _then) = _$EspnRefereeCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String displayName, String shortName, String homeAway
});




}
/// @nodoc
class _$EspnRefereeCopyWithImpl<$Res>
    implements $EspnRefereeCopyWith<$Res> {
  _$EspnRefereeCopyWithImpl(this._self, this._then);

  final EspnReferee _self;
  final $Res Function(EspnReferee) _then;

/// Create a copy of EspnReferee
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? displayName = null,Object? shortName = null,Object? homeAway = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,shortName: null == shortName ? _self.shortName : shortName // ignore: cast_nullable_to_non_nullable
as String,homeAway: null == homeAway ? _self.homeAway : homeAway // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnReferee].
extension EspnRefereePatterns on EspnReferee {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnReferee value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnReferee() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnReferee value)  $default,){
final _that = this;
switch (_that) {
case _EspnReferee():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnReferee value)?  $default,){
final _that = this;
switch (_that) {
case _EspnReferee() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String displayName,  String shortName,  String homeAway)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnReferee() when $default != null:
return $default(_that.id,_that.fullName,_that.displayName,_that.shortName,_that.homeAway);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String displayName,  String shortName,  String homeAway)  $default,) {final _that = this;
switch (_that) {
case _EspnReferee():
return $default(_that.id,_that.fullName,_that.displayName,_that.shortName,_that.homeAway);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String displayName,  String shortName,  String homeAway)?  $default,) {final _that = this;
switch (_that) {
case _EspnReferee() when $default != null:
return $default(_that.id,_that.fullName,_that.displayName,_that.shortName,_that.homeAway);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnReferee implements EspnReferee {
  const _EspnReferee({required this.id, required this.fullName, required this.displayName, required this.shortName, required this.homeAway});
  factory _EspnReferee.fromJson(Map<String, dynamic> json) => _$EspnRefereeFromJson(json);

@override final  String id;
@override final  String fullName;
@override final  String displayName;
@override final  String shortName;
@override final  String homeAway;

/// Create a copy of EspnReferee
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnRefereeCopyWith<_EspnReferee> get copyWith => __$EspnRefereeCopyWithImpl<_EspnReferee>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnRefereeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnReferee&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.shortName, shortName) || other.shortName == shortName)&&(identical(other.homeAway, homeAway) || other.homeAway == homeAway));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,displayName,shortName,homeAway);

@override
String toString() {
  return 'EspnReferee(id: $id, fullName: $fullName, displayName: $displayName, shortName: $shortName, homeAway: $homeAway)';
}


}

/// @nodoc
abstract mixin class _$EspnRefereeCopyWith<$Res> implements $EspnRefereeCopyWith<$Res> {
  factory _$EspnRefereeCopyWith(_EspnReferee value, $Res Function(_EspnReferee) _then) = __$EspnRefereeCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String displayName, String shortName, String homeAway
});




}
/// @nodoc
class __$EspnRefereeCopyWithImpl<$Res>
    implements _$EspnRefereeCopyWith<$Res> {
  __$EspnRefereeCopyWithImpl(this._self, this._then);

  final _EspnReferee _self;
  final $Res Function(_EspnReferee) _then;

/// Create a copy of EspnReferee
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? displayName = null,Object? shortName = null,Object? homeAway = null,}) {
  return _then(_EspnReferee(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,shortName: null == shortName ? _self.shortName : shortName // ignore: cast_nullable_to_non_nullable
as String,homeAway: null == homeAway ? _self.homeAway : homeAway // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EspnWeek {

 int get number;
/// Create a copy of EspnWeek
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnWeekCopyWith<EspnWeek> get copyWith => _$EspnWeekCopyWithImpl<EspnWeek>(this as EspnWeek, _$identity);

  /// Serializes this EspnWeek to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnWeek&&(identical(other.number, number) || other.number == number));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number);

@override
String toString() {
  return 'EspnWeek(number: $number)';
}


}

/// @nodoc
abstract mixin class $EspnWeekCopyWith<$Res>  {
  factory $EspnWeekCopyWith(EspnWeek value, $Res Function(EspnWeek) _then) = _$EspnWeekCopyWithImpl;
@useResult
$Res call({
 int number
});




}
/// @nodoc
class _$EspnWeekCopyWithImpl<$Res>
    implements $EspnWeekCopyWith<$Res> {
  _$EspnWeekCopyWithImpl(this._self, this._then);

  final EspnWeek _self;
  final $Res Function(EspnWeek) _then;

/// Create a copy of EspnWeek
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,}) {
  return _then(_self.copyWith(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnWeek].
extension EspnWeekPatterns on EspnWeek {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnWeek value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnWeek() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnWeek value)  $default,){
final _that = this;
switch (_that) {
case _EspnWeek():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnWeek value)?  $default,){
final _that = this;
switch (_that) {
case _EspnWeek() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnWeek() when $default != null:
return $default(_that.number);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number)  $default,) {final _that = this;
switch (_that) {
case _EspnWeek():
return $default(_that.number);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number)?  $default,) {final _that = this;
switch (_that) {
case _EspnWeek() when $default != null:
return $default(_that.number);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnWeek implements EspnWeek {
  const _EspnWeek({required this.number});
  factory _EspnWeek.fromJson(Map<String, dynamic> json) => _$EspnWeekFromJson(json);

@override final  int number;

/// Create a copy of EspnWeek
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnWeekCopyWith<_EspnWeek> get copyWith => __$EspnWeekCopyWithImpl<_EspnWeek>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnWeekToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnWeek&&(identical(other.number, number) || other.number == number));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number);

@override
String toString() {
  return 'EspnWeek(number: $number)';
}


}

/// @nodoc
abstract mixin class _$EspnWeekCopyWith<$Res> implements $EspnWeekCopyWith<$Res> {
  factory _$EspnWeekCopyWith(_EspnWeek value, $Res Function(_EspnWeek) _then) = __$EspnWeekCopyWithImpl;
@override @useResult
$Res call({
 int number
});




}
/// @nodoc
class __$EspnWeekCopyWithImpl<$Res>
    implements _$EspnWeekCopyWith<$Res> {
  __$EspnWeekCopyWithImpl(this._self, this._then);

  final _EspnWeek _self;
  final $Res Function(_EspnWeek) _then;

/// Create a copy of EspnWeek
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,}) {
  return _then(_EspnWeek(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$EspnSeason {

 int get year; int get type;
/// Create a copy of EspnSeason
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnSeasonCopyWith<EspnSeason> get copyWith => _$EspnSeasonCopyWithImpl<EspnSeason>(this as EspnSeason, _$identity);

  /// Serializes this EspnSeason to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnSeason&&(identical(other.year, year) || other.year == year)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,type);

@override
String toString() {
  return 'EspnSeason(year: $year, type: $type)';
}


}

/// @nodoc
abstract mixin class $EspnSeasonCopyWith<$Res>  {
  factory $EspnSeasonCopyWith(EspnSeason value, $Res Function(EspnSeason) _then) = _$EspnSeasonCopyWithImpl;
@useResult
$Res call({
 int year, int type
});




}
/// @nodoc
class _$EspnSeasonCopyWithImpl<$Res>
    implements $EspnSeasonCopyWith<$Res> {
  _$EspnSeasonCopyWithImpl(this._self, this._then);

  final EspnSeason _self;
  final $Res Function(EspnSeason) _then;

/// Create a copy of EspnSeason
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? type = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EspnSeason].
extension EspnSeasonPatterns on EspnSeason {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnSeason value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnSeason() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnSeason value)  $default,){
final _that = this;
switch (_that) {
case _EspnSeason():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnSeason value)?  $default,){
final _that = this;
switch (_that) {
case _EspnSeason() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnSeason() when $default != null:
return $default(_that.year,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int type)  $default,) {final _that = this;
switch (_that) {
case _EspnSeason():
return $default(_that.year,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int type)?  $default,) {final _that = this;
switch (_that) {
case _EspnSeason() when $default != null:
return $default(_that.year,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnSeason implements EspnSeason {
  const _EspnSeason({required this.year, required this.type});
  factory _EspnSeason.fromJson(Map<String, dynamic> json) => _$EspnSeasonFromJson(json);

@override final  int year;
@override final  int type;

/// Create a copy of EspnSeason
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnSeasonCopyWith<_EspnSeason> get copyWith => __$EspnSeasonCopyWithImpl<_EspnSeason>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnSeasonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnSeason&&(identical(other.year, year) || other.year == year)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,type);

@override
String toString() {
  return 'EspnSeason(year: $year, type: $type)';
}


}

/// @nodoc
abstract mixin class _$EspnSeasonCopyWith<$Res> implements $EspnSeasonCopyWith<$Res> {
  factory _$EspnSeasonCopyWith(_EspnSeason value, $Res Function(_EspnSeason) _then) = __$EspnSeasonCopyWithImpl;
@override @useResult
$Res call({
 int year, int type
});




}
/// @nodoc
class __$EspnSeasonCopyWithImpl<$Res>
    implements _$EspnSeasonCopyWith<$Res> {
  __$EspnSeasonCopyWithImpl(this._self, this._then);

  final _EspnSeason _self;
  final $Res Function(_EspnSeason) _then;

/// Create a copy of EspnSeason
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? type = null,}) {
  return _then(_EspnSeason(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$EspnNflResponse {

 String get league; EspnSeason get season; EspnWeek get week; List<EspnGame> get events;
/// Create a copy of EspnNflResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnNflResponseCopyWith<EspnNflResponse> get copyWith => _$EspnNflResponseCopyWithImpl<EspnNflResponse>(this as EspnNflResponse, _$identity);

  /// Serializes this EspnNflResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnNflResponse&&(identical(other.league, league) || other.league == league)&&(identical(other.season, season) || other.season == season)&&(identical(other.week, week) || other.week == week)&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,league,season,week,const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'EspnNflResponse(league: $league, season: $season, week: $week, events: $events)';
}


}

/// @nodoc
abstract mixin class $EspnNflResponseCopyWith<$Res>  {
  factory $EspnNflResponseCopyWith(EspnNflResponse value, $Res Function(EspnNflResponse) _then) = _$EspnNflResponseCopyWithImpl;
@useResult
$Res call({
 String league, EspnSeason season, EspnWeek week, List<EspnGame> events
});


$EspnSeasonCopyWith<$Res> get season;$EspnWeekCopyWith<$Res> get week;

}
/// @nodoc
class _$EspnNflResponseCopyWithImpl<$Res>
    implements $EspnNflResponseCopyWith<$Res> {
  _$EspnNflResponseCopyWithImpl(this._self, this._then);

  final EspnNflResponse _self;
  final $Res Function(EspnNflResponse) _then;

/// Create a copy of EspnNflResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? league = null,Object? season = null,Object? week = null,Object? events = null,}) {
  return _then(_self.copyWith(
league: null == league ? _self.league : league // ignore: cast_nullable_to_non_nullable
as String,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as EspnSeason,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as EspnWeek,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<EspnGame>,
  ));
}
/// Create a copy of EspnNflResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnSeasonCopyWith<$Res> get season {
  
  return $EspnSeasonCopyWith<$Res>(_self.season, (value) {
    return _then(_self.copyWith(season: value));
  });
}/// Create a copy of EspnNflResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnWeekCopyWith<$Res> get week {
  
  return $EspnWeekCopyWith<$Res>(_self.week, (value) {
    return _then(_self.copyWith(week: value));
  });
}
}


/// Adds pattern-matching-related methods to [EspnNflResponse].
extension EspnNflResponsePatterns on EspnNflResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnNflResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnNflResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnNflResponse value)  $default,){
final _that = this;
switch (_that) {
case _EspnNflResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnNflResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EspnNflResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String league,  EspnSeason season,  EspnWeek week,  List<EspnGame> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnNflResponse() when $default != null:
return $default(_that.league,_that.season,_that.week,_that.events);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String league,  EspnSeason season,  EspnWeek week,  List<EspnGame> events)  $default,) {final _that = this;
switch (_that) {
case _EspnNflResponse():
return $default(_that.league,_that.season,_that.week,_that.events);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String league,  EspnSeason season,  EspnWeek week,  List<EspnGame> events)?  $default,) {final _that = this;
switch (_that) {
case _EspnNflResponse() when $default != null:
return $default(_that.league,_that.season,_that.week,_that.events);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnNflResponse implements EspnNflResponse {
  const _EspnNflResponse({required this.league, required this.season, required this.week, required final  List<EspnGame> events}): _events = events;
  factory _EspnNflResponse.fromJson(Map<String, dynamic> json) => _$EspnNflResponseFromJson(json);

@override final  String league;
@override final  EspnSeason season;
@override final  EspnWeek week;
 final  List<EspnGame> _events;
@override List<EspnGame> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of EspnNflResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnNflResponseCopyWith<_EspnNflResponse> get copyWith => __$EspnNflResponseCopyWithImpl<_EspnNflResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnNflResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnNflResponse&&(identical(other.league, league) || other.league == league)&&(identical(other.season, season) || other.season == season)&&(identical(other.week, week) || other.week == week)&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,league,season,week,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'EspnNflResponse(league: $league, season: $season, week: $week, events: $events)';
}


}

/// @nodoc
abstract mixin class _$EspnNflResponseCopyWith<$Res> implements $EspnNflResponseCopyWith<$Res> {
  factory _$EspnNflResponseCopyWith(_EspnNflResponse value, $Res Function(_EspnNflResponse) _then) = __$EspnNflResponseCopyWithImpl;
@override @useResult
$Res call({
 String league, EspnSeason season, EspnWeek week, List<EspnGame> events
});


@override $EspnSeasonCopyWith<$Res> get season;@override $EspnWeekCopyWith<$Res> get week;

}
/// @nodoc
class __$EspnNflResponseCopyWithImpl<$Res>
    implements _$EspnNflResponseCopyWith<$Res> {
  __$EspnNflResponseCopyWithImpl(this._self, this._then);

  final _EspnNflResponse _self;
  final $Res Function(_EspnNflResponse) _then;

/// Create a copy of EspnNflResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? league = null,Object? season = null,Object? week = null,Object? events = null,}) {
  return _then(_EspnNflResponse(
league: null == league ? _self.league : league // ignore: cast_nullable_to_non_nullable
as String,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as EspnSeason,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as EspnWeek,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<EspnGame>,
  ));
}

/// Create a copy of EspnNflResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnSeasonCopyWith<$Res> get season {
  
  return $EspnSeasonCopyWith<$Res>(_self.season, (value) {
    return _then(_self.copyWith(season: value));
  });
}/// Create a copy of EspnNflResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnWeekCopyWith<$Res> get week {
  
  return $EspnWeekCopyWith<$Res>(_self.week, (value) {
    return _then(_self.copyWith(week: value));
  });
}
}


/// @nodoc
mixin _$EspnTeamsResponse {

 String get league; EspnSeason get season; List<EspnTeam> get teams;
/// Create a copy of EspnTeamsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EspnTeamsResponseCopyWith<EspnTeamsResponse> get copyWith => _$EspnTeamsResponseCopyWithImpl<EspnTeamsResponse>(this as EspnTeamsResponse, _$identity);

  /// Serializes this EspnTeamsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EspnTeamsResponse&&(identical(other.league, league) || other.league == league)&&(identical(other.season, season) || other.season == season)&&const DeepCollectionEquality().equals(other.teams, teams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,league,season,const DeepCollectionEquality().hash(teams));

@override
String toString() {
  return 'EspnTeamsResponse(league: $league, season: $season, teams: $teams)';
}


}

/// @nodoc
abstract mixin class $EspnTeamsResponseCopyWith<$Res>  {
  factory $EspnTeamsResponseCopyWith(EspnTeamsResponse value, $Res Function(EspnTeamsResponse) _then) = _$EspnTeamsResponseCopyWithImpl;
@useResult
$Res call({
 String league, EspnSeason season, List<EspnTeam> teams
});


$EspnSeasonCopyWith<$Res> get season;

}
/// @nodoc
class _$EspnTeamsResponseCopyWithImpl<$Res>
    implements $EspnTeamsResponseCopyWith<$Res> {
  _$EspnTeamsResponseCopyWithImpl(this._self, this._then);

  final EspnTeamsResponse _self;
  final $Res Function(EspnTeamsResponse) _then;

/// Create a copy of EspnTeamsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? league = null,Object? season = null,Object? teams = null,}) {
  return _then(_self.copyWith(
league: null == league ? _self.league : league // ignore: cast_nullable_to_non_nullable
as String,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as EspnSeason,teams: null == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as List<EspnTeam>,
  ));
}
/// Create a copy of EspnTeamsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnSeasonCopyWith<$Res> get season {
  
  return $EspnSeasonCopyWith<$Res>(_self.season, (value) {
    return _then(_self.copyWith(season: value));
  });
}
}


/// Adds pattern-matching-related methods to [EspnTeamsResponse].
extension EspnTeamsResponsePatterns on EspnTeamsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EspnTeamsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EspnTeamsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EspnTeamsResponse value)  $default,){
final _that = this;
switch (_that) {
case _EspnTeamsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EspnTeamsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EspnTeamsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String league,  EspnSeason season,  List<EspnTeam> teams)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EspnTeamsResponse() when $default != null:
return $default(_that.league,_that.season,_that.teams);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String league,  EspnSeason season,  List<EspnTeam> teams)  $default,) {final _that = this;
switch (_that) {
case _EspnTeamsResponse():
return $default(_that.league,_that.season,_that.teams);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String league,  EspnSeason season,  List<EspnTeam> teams)?  $default,) {final _that = this;
switch (_that) {
case _EspnTeamsResponse() when $default != null:
return $default(_that.league,_that.season,_that.teams);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EspnTeamsResponse implements EspnTeamsResponse {
  const _EspnTeamsResponse({required this.league, required this.season, required final  List<EspnTeam> teams}): _teams = teams;
  factory _EspnTeamsResponse.fromJson(Map<String, dynamic> json) => _$EspnTeamsResponseFromJson(json);

@override final  String league;
@override final  EspnSeason season;
 final  List<EspnTeam> _teams;
@override List<EspnTeam> get teams {
  if (_teams is EqualUnmodifiableListView) return _teams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teams);
}


/// Create a copy of EspnTeamsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EspnTeamsResponseCopyWith<_EspnTeamsResponse> get copyWith => __$EspnTeamsResponseCopyWithImpl<_EspnTeamsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EspnTeamsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EspnTeamsResponse&&(identical(other.league, league) || other.league == league)&&(identical(other.season, season) || other.season == season)&&const DeepCollectionEquality().equals(other._teams, _teams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,league,season,const DeepCollectionEquality().hash(_teams));

@override
String toString() {
  return 'EspnTeamsResponse(league: $league, season: $season, teams: $teams)';
}


}

/// @nodoc
abstract mixin class _$EspnTeamsResponseCopyWith<$Res> implements $EspnTeamsResponseCopyWith<$Res> {
  factory _$EspnTeamsResponseCopyWith(_EspnTeamsResponse value, $Res Function(_EspnTeamsResponse) _then) = __$EspnTeamsResponseCopyWithImpl;
@override @useResult
$Res call({
 String league, EspnSeason season, List<EspnTeam> teams
});


@override $EspnSeasonCopyWith<$Res> get season;

}
/// @nodoc
class __$EspnTeamsResponseCopyWithImpl<$Res>
    implements _$EspnTeamsResponseCopyWith<$Res> {
  __$EspnTeamsResponseCopyWithImpl(this._self, this._then);

  final _EspnTeamsResponse _self;
  final $Res Function(_EspnTeamsResponse) _then;

/// Create a copy of EspnTeamsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? league = null,Object? season = null,Object? teams = null,}) {
  return _then(_EspnTeamsResponse(
league: null == league ? _self.league : league // ignore: cast_nullable_to_non_nullable
as String,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as EspnSeason,teams: null == teams ? _self._teams : teams // ignore: cast_nullable_to_non_nullable
as List<EspnTeam>,
  ));
}

/// Create a copy of EspnTeamsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EspnSeasonCopyWith<$Res> get season {
  
  return $EspnSeasonCopyWith<$Res>(_self.season, (value) {
    return _then(_self.copyWith(season: value));
  });
}
}

// dart format on
