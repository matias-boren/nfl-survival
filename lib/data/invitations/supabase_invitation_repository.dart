import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pick1/data/invitations/invitation_repositories.dart';
import 'package:pick1/data/models/league_invitation.dart';

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
      
      final insertData = {
        '"leagueId"': leagueId,
        '"invitedByUserId"': invitedByUserId,
        '"invitationCode"': invitationCode,
        'status': 'pending',
        '"createdAt"': DateTime.now().toIso8601String(),
        '"expiresAt"': expiresAt.toIso8601String(),
      };
      
      print('Inserting data: $insertData');
      
      final response = await _supabase
          .from('league_invitations')
          .insert(insertData)
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
          .eq('"invitationCode"', invitationCode)
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
      print('Getting invitations for league: $leagueId');
      
      final response = await _supabase
          .from('league_invitations')
          .select()
          .eq('"leagueId"', leagueId)
          .order('"createdAt"', ascending: false);

      print('Raw response from Supabase: $response');
      
      final invitations = response
          .map((json) => LeagueInvitation.fromJson(json))
          .toList();
          
      print('Parsed invitations: ${invitations.length} invitations found');
      
      return invitations;
    } catch (e) {
      print('Error getting invitations for league: $e');
      print('Error details: ${e.toString()}');
      return [];
    }
  }

  @override
  Future<List<LeagueInvitation>> getPendingInvitationsForUser(String userId) async {
    try {
      final response = await _supabase
          .from('league_invitations')
          .select()
          .eq('"invitedUserId"', userId)
          .eq('status', 'pending')
          .order('"createdAt"', ascending: false);

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
            '"invitedUserId"': userId,
            '"acceptedAt"': DateTime.now().toIso8601String(),
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
            '"declinedAt"': DateTime.now().toIso8601String(),
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
    // Generate a truly random 8-character code
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
    if (invitation.expiresAt == null) return true;
    return DateTime.now().isBefore(invitation.expiresAt!);
  }
}
