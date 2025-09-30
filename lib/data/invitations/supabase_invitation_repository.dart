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
      
      final response = await _supabase
          .from('league_invitations')
          .insert({
            'league_id': leagueId,
            'invited_by_user_id': invitedByUserId,
            'invitation_code': invitationCode,
            'status': 'pending',
            'created_at': DateTime.now().toIso8601String(),
            'expires_at': expiresAt.toIso8601String(),
          })
          .select()
          .single();

      return LeagueInvitation.fromJson(response);
    } catch (e) {
      print('Error creating invitation: $e');
      rethrow;
    }
  }

  @override
  Future<LeagueInvitation?> getInvitationByCode(String invitationCode) async {
    try {
      final response = await _supabase
          .from('league_invitations')
          .select()
          .eq('invitation_code', invitationCode)
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
          .eq('league_id', leagueId)
          .order('created_at', ascending: false);

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
          .eq('invited_user_id', userId)
          .eq('status', 'pending')
          .order('created_at', ascending: false);

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
            'invited_user_id': userId,
            'accepted_at': DateTime.now().toIso8601String(),
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
            'declined_at': DateTime.now().toIso8601String(),
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
