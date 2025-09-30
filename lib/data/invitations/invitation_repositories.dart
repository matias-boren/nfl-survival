import 'package:pick1/data/models/league_invitation.dart';

abstract class InvitationRepository {
  // Create a new invitation
  Future<LeagueInvitation> createInvitation({
    required String leagueId,
    required String invitedByUserId,
  });

  // Get invitation by code
  Future<LeagueInvitation?> getInvitationByCode(String invitationCode);

  // Get invitations for a league
  Future<List<LeagueInvitation>> getInvitationsForLeague(String leagueId);

  // Get pending invitations for a user
  Future<List<LeagueInvitation>> getPendingInvitationsForUser(String userId);

  // Accept an invitation
  Future<LeagueInvitation> acceptInvitation(String invitationId, String userId);

  // Decline an invitation
  Future<LeagueInvitation> declineInvitation(String invitationId);

  // Cancel an invitation
  Future<void> cancelInvitation(String invitationId);

  // Generate invitation code
  String generateInvitationCode();

  // Check if invitation is valid
  bool isInvitationValid(LeagueInvitation invitation);
}
