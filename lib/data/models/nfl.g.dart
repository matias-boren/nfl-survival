// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nfl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Team _$TeamFromJson(Map<String, dynamic> json) => _Team(
  id: json['id'] as String,
  name: json['name'] as String,
  abbr: json['abbr'] as String,
);

Map<String, dynamic> _$TeamToJson(_Team instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'abbr': instance.abbr,
};

_Game _$GameFromJson(Map<String, dynamic> json) => _Game(
  id: json['id'] as String,
  week: (json['week'] as num).toInt(),
  homeId: json['homeId'] as String,
  awayId: json['awayId'] as String,
  startIso: json['startIso'] as String,
  status: $enumDecode(_$GameStatusEnumMap, json['status']),
  homeScore: (json['homeScore'] as num?)?.toInt(),
  awayScore: (json['awayScore'] as num?)?.toInt(),
);

Map<String, dynamic> _$GameToJson(_Game instance) => <String, dynamic>{
  'id': instance.id,
  'week': instance.week,
  'homeId': instance.homeId,
  'awayId': instance.awayId,
  'startIso': instance.startIso,
  'status': _$GameStatusEnumMap[instance.status]!,
  'homeScore': instance.homeScore,
  'awayScore': instance.awayScore,
};

const _$GameStatusEnumMap = {
  GameStatus.SCHEDULED: 'SCHEDULED',
  GameStatus.LIVE: 'LIVE',
  GameStatus.FINAL: 'FINAL',
};
