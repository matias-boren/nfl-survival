// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Team _$TeamFromJson(Map<String, dynamic> json) => _Team(
  id: json['id'] as String,
  espnTeamId: json['espnTeamId'] as String,
  name: json['name'] as String,
  abbreviation: json['abbreviation'] as String,
  city: json['city'] as String,
  conference: json['conference'] as String,
  division: json['division'] as String,
  logoUrl: json['logoUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TeamToJson(_Team instance) => <String, dynamic>{
  'id': instance.id,
  'espnTeamId': instance.espnTeamId,
  'name': instance.name,
  'abbreviation': instance.abbreviation,
  'city': instance.city,
  'conference': instance.conference,
  'division': instance.division,
  'logoUrl': instance.logoUrl,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_TeamRecord _$TeamRecordFromJson(Map<String, dynamic> json) => _TeamRecord(
  id: json['id'] as String,
  teamId: json['teamId'] as String,
  season: (json['season'] as num).toInt(),
  week: (json['week'] as num).toInt(),
  wins: (json['wins'] as num).toInt(),
  losses: (json['losses'] as num).toInt(),
  ties: (json['ties'] as num).toInt(),
  lastUpdated: DateTime.parse(json['lastUpdated'] as String),
);

Map<String, dynamic> _$TeamRecordToJson(_TeamRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teamId': instance.teamId,
      'season': instance.season,
      'week': instance.week,
      'wins': instance.wins,
      'losses': instance.losses,
      'ties': instance.ties,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };

_TeamWithRecord _$TeamWithRecordFromJson(Map<String, dynamic> json) =>
    _TeamWithRecord(
      team: Team.fromJson(json['team'] as Map<String, dynamic>),
      record: json['record'] == null
          ? null
          : TeamRecord.fromJson(json['record'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamWithRecordToJson(_TeamWithRecord instance) =>
    <String, dynamic>{'team': instance.team, 'record': instance.record};
