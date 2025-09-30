import 'dart:math';
import 'package:pick1/data/invitations/invitation_repositories.dart';
import 'package:pick1/data/models/league_invitation.dart';

class MockInvitationRepository implements InvitationRepository {
  final List<LeagueInvitation> _invitations = [];

  @override
  Future<LeagueInvitation> createInvitation({
    required String leagueId,
    required String invitedByUserId,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate network delay

    final invitation = LeagueInvitation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      leagueId: leagueId,
      invitedByUserId: invitedByUserId,
      invitedUserEmail: null, // No email needed for URL-based invitations
      invitationCode: generateInvitationCode(),
      status: InvitationStatus.pending,
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(days: 7)), // 7 days expiry
    );

    _invitations.add(invitation);
    return invitation;
  }

  @override
  Future<LeagueInvitation?> getInvitationByCode(String invitationCode) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      return _invitations.firstWhere(
        (invitation) => invitation.invitationCode == invitationCode,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<LeagueInvitation>> getInvitationsForLeague(
    String leagueId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _invitations
        .where((invitation) => invitation.leagueId == leagueId)
        .toList();
  }

  @override
  Future<List<LeagueInvitation>> getPendingInvitationsForUser(
    String userId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _invitations
        .where(
          (invitation) =>
              invitation.invitedUserId == userId &&
              invitation.status == InvitationStatus.pending,
        )
        .toList();
  }

  @override
  Future<LeagueInvitation> acceptInvitation(
    String invitationId,
    String userId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final invitationIndex = _invitations.indexWhere(
      (inv) => inv.id == invitationId,
    );
    if (invitationIndex == -1) {
      throw Exception('Invitation not found');
    }

    final updatedInvitation = _invitations[invitationIndex].copyWith(
      status: InvitationStatus.accepted,
      invitedUserId: userId,
      acceptedAt: DateTime.now(),
    );

    _invitations[invitationIndex] = updatedInvitation;
    return updatedInvitation;
  }

  @override
  Future<LeagueInvitation> declineInvitation(String invitationId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final invitationIndex = _invitations.indexWhere(
      (inv) => inv.id == invitationId,
    );
    if (invitationIndex == -1) {
      throw Exception('Invitation not found');
    }

    final updatedInvitation = _invitations[invitationIndex].copyWith(
      status: InvitationStatus.declined,
      declinedAt: DateTime.now(),
    );

    _invitations[invitationIndex] = updatedInvitation;
    return updatedInvitation;
  }

  @override
  Future<void> cancelInvitation(String invitationId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    _invitations.removeWhere((invitation) => invitation.id == invitationId);
  }

  @override
  String generateInvitationCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        8,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  @override
  bool isInvitationValid(LeagueInvitation invitation) {
    if (invitation.status != InvitationStatus.pending) return false;
    if (invitation.expiresAt != null &&
        DateTime.now().isAfter(invitation.expiresAt!)) {
      return false;
    }
    return true;
  }
}
