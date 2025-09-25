import 'package:freezed_annotation/freezed_annotation.dart';

part 'league_invitation.freezed.dart';
part 'league_invitation.g.dart';

@freezed
abstract class LeagueInvitation with _$LeagueInvitation {
  const factory LeagueInvitation({
    required String id,
    required String leagueId,
    required String invitedByUserId,
    String? invitedUserEmail,
    String? invitedUserId, // Set when user accepts
    required String invitationCode,
    required InvitationStatus status,
    required DateTime createdAt,
    DateTime? expiresAt,
    DateTime? acceptedAt,
    DateTime? declinedAt,
  }) = _LeagueInvitation;

  factory LeagueInvitation.fromJson(Map<String, dynamic> json) => _$LeagueInvitationFromJson(json);
}

enum InvitationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('declined')
  declined,
  @JsonValue('expired')
  expired,
}

