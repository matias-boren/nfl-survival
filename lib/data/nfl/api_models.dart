import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_models.freezed.dart';
part 'api_models.g.dart';

// ESPN API Models for NFL Data
@freezed
class EspnGame with _$EspnGame {
  const factory EspnGame({
    required String id,
    required String name,
    required String shortName,
    required EspnDate date,
    required List<EspnCompetition> competitions,
    required EspnStatus status,
    required EspnWeek week,
    required EspnSeason season,
  }) = _EspnGame;

  factory EspnGame.fromJson(Map<String, dynamic> json) => _$EspnGameFromJson(json);
}

@freezed
class EspnDate with _$EspnDate {
  const factory EspnDate({
    required String date,
  }) = _EspnDate;

  factory EspnDate.fromJson(Map<String, dynamic> json) => _$EspnDateFromJson(json);
}

@freezed
class EspnCompetition with _$EspnCompetition {
  const factory EspnCompetition({
    required String id,
    required String uid,
    required String date,
    required String attendance,
    required EspnType type,
    required bool timeValid,
    required List<EspnCompetitor> competitors,
    required EspnStatus status,
    required EspnBroadcast? broadcast,
    required EspnVenue venue,
    required List<EspnStartDate> startDate,
    required List<EspnWeather> weather,
    required EspnReferee? referee,
  }) = _EspnCompetition;

  factory EspnCompetition.fromJson(Map<String, dynamic> json) => _$EspnCompetitionFromJson(json);
}

@freezed
class EspnCompetitor with _$EspnCompetitor {
  const factory EspnCompetitor({
    required String id,
    required String uid,
    required String type,
    required String order,
    required String homeAway,
    required EspnTeam team,
    required EspnScore? score,
    required List<EspnRecord> records,
    required List<EspnWinner>? winners,
    required List<EspnStatistic>? statistics,
    required List<EspnLeader>? leaders,
  }) = _EspnCompetitor;

  factory EspnCompetitor.fromJson(Map<String, dynamic> json) => _$EspnCompetitorFromJson(json);
}

@freezed
class EspnTeam with _$EspnTeam {
  const factory EspnTeam({
    required String id,
    required String uid,
    required String location,
    required String name,
    required String abbreviation,
    required String displayName,
    required String shortDisplayName,
    required String color,
    required String alternateColor,
    required bool isActive,
    required EspnLogo logo,
  }) = _EspnTeam;

  factory EspnTeam.fromJson(Map<String, dynamic> json) => _$EspnTeamFromJson(json);
}

@freezed
class EspnLogo with _$EspnLogo {
  const factory EspnLogo({
    required String href,
    required int width,
    required int height,
    required String alt,
    required List<String> rel,
  }) = _EspnLogo;

  factory EspnLogo.fromJson(Map<String, dynamic> json) => _$EspnLogoFromJson(json);
}

@freezed
class EspnScore with _$EspnScore {
  const factory EspnScore({
    required String value,
    required String displayValue,
  }) = _EspnScore;

  factory EspnScore.fromJson(Map<String, dynamic> json) => _$EspnScoreFromJson(json);
}

@freezed
class EspnRecord with _$EspnRecord {
  const factory EspnRecord({
    required String name,
    required String abbreviation,
    required String type,
    required String summary,
  }) = _EspnRecord;

  factory EspnRecord.fromJson(Map<String, dynamic> json) => _$EspnRecordFromJson(json);
}

@freezed
class EspnWinner with _$EspnWinner {
  const factory EspnWinner({
    required String value,
    required String displayValue,
  }) = _EspnWinner;

  factory EspnWinner.fromJson(Map<String, dynamic> json) => _$EspnWinnerFromJson(json);
}

@freezed
class EspnStatistic with _$EspnStatistic {
  const factory EspnStatistic({
    required String label,
    required String value,
  }) = _EspnStatistic;

  factory EspnStatistic.fromJson(Map<String, dynamic> json) => _$EspnStatisticFromJson(json);
}

@freezed
class EspnLeader with _$EspnLeader {
  const factory EspnLeader({
    required String displayName,
    required String shortDisplayName,
    required String abbreviation,
    required EspnLeaderLeaders leaders,
  }) = _EspnLeader;

  factory EspnLeader.fromJson(Map<String, dynamic> json) => _$EspnLeaderFromJson(json);
}

@freezed
class EspnLeaderLeaders with _$EspnLeaderLeaders {
  const factory EspnLeaderLeaders({
    required String value,
    required String displayValue,
  }) = _EspnLeaderLeaders;

  factory EspnLeaderLeaders.fromJson(Map<String, dynamic> json) => _$EspnLeaderLeadersFromJson(json);
}

@freezed
class EspnStatus with _$EspnStatus {
  const factory EspnStatus({
    required int clock,
    required String displayClock,
    required int period,
    required EspnType type,
    required bool completed,
    required String description,
    required String detail,
    required String shortDetail,
  }) = _EspnStatus;

  factory EspnStatus.fromJson(Map<String, dynamic> json) => _$EspnStatusFromJson(json);
}

@freezed
class EspnType with _$EspnType {
  const factory EspnType({
    required String id,
    required String abbreviation,
  }) = _EspnType;

  factory EspnType.fromJson(Map<String, dynamic> json) => _$EspnTypeFromJson(json);
}

@freezed
class EspnBroadcast with _$EspnBroadcast {
  const factory EspnBroadcast({
    required String market,
    required List<String> names,
  }) = _EspnBroadcast;

  factory EspnBroadcast.fromJson(Map<String, dynamic> json) => _$EspnBroadcastFromJson(json);
}

@freezed
class EspnVenue with _$EspnVenue {
  const factory EspnVenue({
    required String id,
    required String fullName,
    required String address,
    required EspnCity city,
    required EspnState state,
    required String zip,
    required String country,
    required int capacity,
    required bool grass,
    required bool indoor,
  }) = _EspnVenue;

  factory EspnVenue.fromJson(Map<String, dynamic> json) => _$EspnVenueFromJson(json);
}

@freezed
class EspnCity with _$EspnCity {
  const factory EspnCity({
    required String id,
    required String name,
  }) = _EspnCity;

  factory EspnCity.fromJson(Map<String, dynamic> json) => _$EspnCityFromJson(json);
}

@freezed
class EspnState with _$EspnState {
  const factory EspnState({
    required String id,
    required String name,
    required String abbreviation,
  }) = _EspnState;

  factory EspnState.fromJson(Map<String, dynamic> json) => _$EspnStateFromJson(json);
}

@freezed
class EspnStartDate with _$EspnStartDate {
  const factory EspnStartDate({
    required String value,
    required String displayValue,
  }) = _EspnStartDate;

  factory EspnStartDate.fromJson(Map<String, dynamic> json) => _$EspnStartDateFromJson(json);
}

@freezed
class EspnWeather with _$EspnWeather {
  const factory EspnWeather({
    required int displayValue,
    required int highTemperature,
    required String conditionId,
    required String link,
  }) = _EspnWeather;

  factory EspnWeather.fromJson(Map<String, dynamic> json) => _$EspnWeatherFromJson(json);
}

@freezed
class EspnReferee with _$EspnReferee {
  const factory EspnReferee({
    required String id,
    required String fullName,
    required String displayName,
    required String shortName,
    required String homeAway,
  }) = _EspnReferee;

  factory EspnReferee.fromJson(Map<String, dynamic> json) => _$EspnRefereeFromJson(json);
}

@freezed
class EspnWeek with _$EspnWeek {
  const factory EspnWeek({
    required int number,
  }) = _EspnWeek;

  factory EspnWeek.fromJson(Map<String, dynamic> json) => _$EspnWeekFromJson(json);
}

@freezed
class EspnSeason with _$EspnSeason {
  const factory EspnSeason({
    required int year,
    required int type,
  }) = _EspnSeason;

  factory EspnSeason.fromJson(Map<String, dynamic> json) => _$EspnSeasonFromJson(json);
}

// ESPN API Response Models
@freezed
class EspnNflResponse with _$EspnNflResponse {
  const factory EspnNflResponse({
    required String league,
    required EspnSeason season,
    required EspnWeek week,
    required List<EspnGame> events,
  }) = _EspnNflResponse;

  factory EspnNflResponse.fromJson(Map<String, dynamic> json) => _$EspnNflResponseFromJson(json);
}

@freezed
class EspnTeamsResponse with _$EspnTeamsResponse {
  const factory EspnTeamsResponse({
    required String league,
    required EspnSeason season,
    required List<EspnTeam> teams,
  }) = _EspnTeamsResponse;

  factory EspnTeamsResponse.fromJson(Map<String, dynamic> json) => _$EspnTeamsResponseFromJson(json);
}
