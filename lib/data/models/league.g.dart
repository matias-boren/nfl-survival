// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeagueSettings _$LeagueSettingsFromJson(Map<String, dynamic> json) =>
    _LeagueSettings(
      maxLosses: (json['maxLosses'] as num).toInt(),
      allowTeamReuse: json['allowTeamReuse'] as bool,
      autoEliminateOnNoPick: json['autoEliminateOnNoPick'] as bool,
      minTeams: (json['minTeams'] as num).toInt(),
      maxTeams: (json['maxTeams'] as num?)?.toInt(),
      tiebreaker: $enumDecode(_$TiebreakerEnumMap, json['tiebreaker']),
    );

Map<String, dynamic> _$LeagueSettingsToJson(_LeagueSettings instance) =>
    <String, dynamic>{
      'maxLosses': instance.maxLosses,
      'allowTeamReuse': instance.allowTeamReuse,
      'autoEliminateOnNoPick': instance.autoEliminateOnNoPick,
      'minTeams': instance.minTeams,
      'maxTeams': instance.maxTeams,
      'tiebreaker': _$TiebreakerEnumMap[instance.tiebreaker]!,
    };

const _$TiebreakerEnumMap = {
  Tiebreaker.LAST_LONGEST_STREAK: 'LAST_LONGEST_STREAK',
  Tiebreaker.MOST_REMAINING_TEAMS: 'MOST_REMAINING_TEAMS',
  Tiebreaker.TOTAL_MARGIN: 'TOTAL_MARGIN',
};

_League _$LeagueFromJson(Map<String, dynamic> json) => _League(
  id: json['id'] as String,
  name: json['name'] as String,
  ownerId: json['ownerId'] as String,
  visibility: $enumDecode(_$LeagueVisibilityEnumMap, json['visibility']),
  settings: LeagueSettings.fromJson(json['settings'] as Map<String, dynamic>),
  season: (json['season'] as num).toInt(),
  createdAtIso: json['createdAtIso'] as String,
  memberIds: (json['memberIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  inviteCode: json['inviteCode'] as String?,
);

Map<String, dynamic> _$LeagueToJson(_League instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'ownerId': instance.ownerId,
  'visibility': _$LeagueVisibilityEnumMap[instance.visibility]!,
  'settings': instance.settings,
  'season': instance.season,
  'createdAtIso': instance.createdAtIso,
  'memberIds': instance.memberIds,
  'inviteCode': instance.inviteCode,
};

const _$LeagueVisibilityEnumMap = {
  LeagueVisibility.PUBLIC: 'PUBLIC',
  LeagueVisibility.PRIVATE: 'PRIVATE',
};
