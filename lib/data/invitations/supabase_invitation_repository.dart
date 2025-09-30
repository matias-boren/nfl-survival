import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nfl_survival/data/invitations/invitation_repositories.dart';
import 'package:nfl_survival/data/models/league_invitation.dart';

class SupabaseInvitationRepository implements InvitationRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<LeagueInvitation> createInvitation({
    required String leagueId,
    required String invitedByUserId,
  }) async {
    try {
      final invitationCode = generateInvitationCode();
      final expiresAt = DateTime.now().add(const Duration(days: 7));
      
      print('Creating invitation with data:');
      print('  leagueId: $leagueId');
      print('  invitedByUserId: $invitedByUserId');
      print('  invitationCode: $invitationCode');
      
      final response = await _supabase
          .from('league_invitations')
          .insert({
            'leagueId': leagueId,
            'invitedByUserId': invitedByUserId,
            'invitationCode': invitationCode,
            'status': 'pending',
            'createdAt': DateTime.now().toIso8601String(),
            'expiresAt': expiresAt.toIso8601String(),
          })
          .select()
          .single();

      print('Invitation created successfully: $response');
      return LeagueInvitation.fromJson(response);
    } catch (e) {
      print('Error creating invitation: $e');
      print('Error details: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<LeagueInvitation?> getInvitationByCode(String invitationCode) async {
    try {
      final response = await _supabase
          .from('league_invitations')
          .select()
          .eq('invitationCode', invitationCode)
          .maybeSingle();

      if (response == null) return null;
      return LeagueInvitation.fromJson(response);
    } catch (e) {
      print('Error getting invitation by code: $e');
      return null;
    }
  }

  @override
  Future<List<LeagueInvitation>> getInvitationsForLeague(String leagueId) async {
    try {
      final response = await _supabase
          .from('league_invitations')
          .select()
          .eq('leagueId', leagueId)
          .order('createdAt', ascending: false);

      return response
          .map((json) => LeagueInvitation.fromJson(json))
          .toList();
    } catch (e) {
      print('Error getting invitations for league: $e');
      return [];
    }
  }

  @override
  Future<List<LeagueInvitation>> getPendingInvitationsForUser(String userId) async {
    try {
      final response = await _supabase
          .from('league_invitations')
          .select()
          .eq('invitedUserId', userId)
          .eq('status', 'pending')
          .order('createdAt', ascending: false);

      return response
          .map((json) => LeagueInvitation.fromJson(json))
          .toList();
    } catch (e) {
      print('Error getting pending invitations for user: $e');
      return [];
    }
  }

  @override
  Future<LeagueInvitation> acceptInvitation(String invitationId, String userId) async {
    try {
      final response = await _supabase
          .from('league_invitations')
          .update({
            'status': 'accepted',
            'invitedUserId': userId,
            'acceptedAt': DateTime.now().toIso8601String(),
          })
          .eq('id', invitationId)
          .select()
          .single();

      return LeagueInvitation.fromJson(response);
    } catch (e) {
      print('Error accepting invitation: $e');
      rethrow;
    }
  }

  @override
  Future<LeagueInvitation> declineInvitation(String invitationId) async {
    try {
      final response = await _supabase
          .from('league_invitations')
          .update({
            'status': 'declined',
            'declinedAt': DateTime.now().toIso8601String(),
          })
          .eq('id', invitationId)
          .select()
          .single();

      return LeagueInvitation.fromJson(response);
    } catch (e) {
      print('Error declining invitation: $e');
      rethrow;
    }
  }

  @override
  Future<void> cancelInvitation(String invitationId) async {
    try {
      await _supabase
          .from('league_invitations')
          .delete()
          .eq('id', invitationId);
    } catch (e) {
      print('Error canceling invitation: $e');
      rethrow;
    }
  }

  @override
  String generateInvitationCode() {
    // Generate a random 8-character code
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    final code = StringBuffer();
    
    for (int i = 0; i < 8; i++) {
      code.write(chars[(random + i) % chars.length]);
    }
    
    return code.toString();
  }

  @override
  bool isInvitationValid(LeagueInvitation invitation) {
    if (invitation.status != InvitationStatus.pending) return false;
    if (invitation.expiresAt == null) return true;
    return DateTime.now().isBefore(invitation.expiresAt!);
  }
}
