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
    );

Map<String, dynamic> _$LeagueSettingsToJson(_LeagueSettings instance) =>
    <String, dynamic>{
      'maxLosses': instance.maxLosses,
      'allowTeamReuse': instance.allowTeamReuse,
      'autoEliminateOnNoPick': instance.autoEliminateOnNoPick,
    };

_LeagueMember _$LeagueMemberFromJson(Map<String, dynamic> json) =>
    _LeagueMember(
      leagueId: json['leagueId'] as String,
      userId: json['userId'] as String,
      losses: (json['losses'] as num).toInt(),
      joinedAt: json['joinedAt'] as String,
    );

Map<String, dynamic> _$LeagueMemberToJson(_LeagueMember instance) =>
    <String, dynamic>{
      'leagueId': instance.leagueId,
      'userId': instance.userId,
      'losses': instance.losses,
      'joinedAt': instance.joinedAt,
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
  memberPoints:
      (json['memberPoints'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  eliminatedUsers:
      (json['eliminatedUsers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ) ??
      const {},
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
  'memberPoints': instance.memberPoints,
  'eliminatedUsers': instance.eliminatedUsers,
};

const _$LeagueVisibilityEnumMap = {
  LeagueVisibility.PUBLIC: 'PUBLIC',
  LeagueVisibility.PRIVATE: 'PRIVATE',
};
