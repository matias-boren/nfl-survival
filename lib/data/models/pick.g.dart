// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Pick _$PickFromJson(Map<String, dynamic> json) => _Pick(
  id: json['id'] as String,
  leagueId: json['leagueId'] as String,
  userId: json['userId'] as String,
  week: (json['week'] as num).toInt(),
  teamId: json['teamId'] as String,
  madeAtIso: json['madeAtIso'] as String,
  locked: json['locked'] as bool,
  result: $enumDecodeNullable(_$PickResultEnumMap, json['result']),
);

Map<String, dynamic> _$PickToJson(_Pick instance) => <String, dynamic>{
  'id': instance.id,
  'leagueId': instance.leagueId,
  'userId': instance.userId,
  'week': instance.week,
  'teamId': instance.teamId,
  'madeAtIso': instance.madeAtIso,
  'locked': instance.locked,
  'result': _$PickResultEnumMap[instance.result],
};

const _$PickResultEnumMap = {
  PickResult.PENDING: 'PENDING',
  PickResult.WIN: 'WIN',
  PickResult.LOSE: 'LOSE',
  PickResult.PUSH: 'PUSH',
};
