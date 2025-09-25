// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeagueInvitation _$LeagueInvitationFromJson(Map<String, dynamic> json) =>
    _LeagueInvitation(
      id: json['id'] as String,
      leagueId: json['leagueId'] as String,
      invitedByUserId: json['invitedByUserId'] as String,
      invitedUserEmail: json['invitedUserEmail'] as String?,
      invitedUserId: json['invitedUserId'] as String?,
      invitationCode: json['invitationCode'] as String,
      status: $enumDecode(_$InvitationStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      acceptedAt: json['acceptedAt'] == null
          ? null
          : DateTime.parse(json['acceptedAt'] as String),
      declinedAt: json['declinedAt'] == null
          ? null
          : DateTime.parse(json['declinedAt'] as String),
    );

Map<String, dynamic> _$LeagueInvitationToJson(_LeagueInvitation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueId': instance.leagueId,
      'invitedByUserId': instance.invitedByUserId,
      'invitedUserEmail': instance.invitedUserEmail,
      'invitedUserId': instance.invitedUserId,
      'invitationCode': instance.invitationCode,
      'status': _$InvitationStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'acceptedAt': instance.acceptedAt?.toIso8601String(),
      'declinedAt': instance.declinedAt?.toIso8601String(),
    };

const _$InvitationStatusEnumMap = {
  InvitationStatus.pending: 'pending',
  InvitationStatus.accepted: 'accepted',
  InvitationStatus.declined: 'declined',
  InvitationStatus.expired: 'expired',
};
