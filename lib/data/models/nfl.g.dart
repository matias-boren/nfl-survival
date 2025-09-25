// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nfl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Team _$TeamFromJson(Map<String, dynamic> json) => _Team(
  id: json['id'] as String,
  name: json['name'] as String,
  abbreviation: json['abbreviation'] as String,
  city: json['city'] as String,
  logoUrl: json['logoUrl'] as String?,
  color: json['color'] as String?,
  alternateColor: json['alternateColor'] as String?,
);

Map<String, dynamic> _$TeamToJson(_Team instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'abbreviation': instance.abbreviation,
  'city': instance.city,
  'logoUrl': instance.logoUrl,
  'color': instance.color,
  'alternateColor': instance.alternateColor,
};

_Game _$GameFromJson(Map<String, dynamic> json) => _Game(
  id: json['id'] as String,
  homeTeam: Team.fromJson(json['homeTeam'] as Map<String, dynamic>),
  awayTeam: Team.fromJson(json['awayTeam'] as Map<String, dynamic>),
  homeScore: (json['homeScore'] as num).toInt(),
  awayScore: (json['awayScore'] as num).toInt(),
  status: $enumDecode(_$GameStatusEnumMap, json['status']),
  quarter: (json['quarter'] as num).toInt(),
  timeRemaining: json['timeRemaining'] as String,
  date: DateTime.parse(json['date'] as String),
  week: (json['week'] as num).toInt(),
  season: (json['season'] as num).toInt(),
);

Map<String, dynamic> _$GameToJson(_Game instance) => <String, dynamic>{
  'id': instance.id,
  'homeTeam': instance.homeTeam,
  'awayTeam': instance.awayTeam,
  'homeScore': instance.homeScore,
  'awayScore': instance.awayScore,
  'status': _$GameStatusEnumMap[instance.status]!,
  'quarter': instance.quarter,
  'timeRemaining': instance.timeRemaining,
  'date': instance.date.toIso8601String(),
  'week': instance.week,
  'season': instance.season,
};

const _$GameStatusEnumMap = {
  GameStatus.SCHEDULED: 'SCHEDULED',
  GameStatus.IN_PROGRESS: 'IN_PROGRESS',
  GameStatus.FINAL: 'FINAL',
};

_LiveScore _$LiveScoreFromJson(Map<String, dynamic> json) => _LiveScore(
  gameId: json['gameId'] as String,
  homeTeam: Team.fromJson(json['homeTeam'] as Map<String, dynamic>),
  awayTeam: Team.fromJson(json['awayTeam'] as Map<String, dynamic>),
  homeScore: (json['homeScore'] as num).toInt(),
  awayScore: (json['awayScore'] as num).toInt(),
  status: json['status'] as String,
  quarter: (json['quarter'] as num).toInt(),
  timeRemaining: json['timeRemaining'] as String,
  isLive: json['isLive'] as bool,
  gameDate: json['gameDate'] == null
      ? null
      : DateTime.parse(json['gameDate'] as String),
);

Map<String, dynamic> _$LiveScoreToJson(_LiveScore instance) =>
    <String, dynamic>{
      'gameId': instance.gameId,
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
      'homeScore': instance.homeScore,
      'awayScore': instance.awayScore,
      'status': instance.status,
      'quarter': instance.quarter,
      'timeRemaining': instance.timeRemaining,
      'isLive': instance.isLive,
      'gameDate': instance.gameDate?.toIso8601String(),
    };
