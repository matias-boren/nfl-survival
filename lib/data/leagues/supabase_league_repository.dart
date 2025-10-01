import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pick1/data/leagues/league_repositories.dart';
import 'package:pick1/data/models/league.dart';
import 'package:pick1/data/models/user.dart' as app_user;

class SupabaseLeagueRepository implements LeagueRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<League> createLeague(League draft) async {
    print('Creating league with ownerId: ${draft.ownerId}');
    print('Current user from auth: ${_supabase.auth.currentUser?.id}');

    final response = await _supabase
        .from('leagues')
        .insert({
          'name': draft.name,
          'max_losses': draft.settings.maxLosses,
          'allow_team_reuse': draft.settings.allowTeamReuse,
          'auto_eliminate_on_no_pick': draft.settings.autoEliminateOnNoPick,
          'visibility': draft.visibility.name,
          'creator_id': draft.ownerId, // Keep creator_id for compatibility
          'owner_id': draft.ownerId, // Also set owner_id
          'season': draft.season,
          'created_at_iso': draft.createdAtIso,
          'invite_code': draft.inviteCode,
          'member_points': draft.memberPoints,
        })
        .select()
        .single();

    // Add the owner to the league_members table
    await _supabase.from('league_members').insert({
      'league_id': response['id'],
      'user_id': draft.ownerId,
    });

    return _leagueFromSupabase(response);
  }

  @override
  Future<List<League>> listLeaguesForUser(String userId) async {
    print('=== listLeaguesForUser called ===');
    print('Listing leagues for user: $userId');
    print('Current auth user: ${_supabase.auth.currentUser?.id}');

    // First, get all leagues where the user is the owner
    final ownedLeagues = await _supabase
        .from('leagues')
        .select('*, league_members(user_id)')
        .eq('owner_id', userId);

    print('Found ${ownedLeagues.length} owned leagues');
    print('Owned leagues: $ownedLeagues');

    // Also try with creator_id
    final ownedLeaguesByCreator = await _supabase
        .from('leagues')
        .select('*, league_members(user_id)')
        .eq('creator_id', userId);

    print('Found ${ownedLeaguesByCreator.length} leagues by creator_id');
    print('Leagues by creator: $ownedLeaguesByCreator');

    // Then, get all leagues where the user is a member
    final memberLeagues = await _supabase
        .from('league_members')
        .select('league_id, leagues(*)')
        .eq('user_id', userId);

    print('Found ${memberLeagues.length} member leagues');
    print('Member leagues: $memberLeagues');

    // Combine all lists and remove duplicates immediately
    final uniqueLeagues = <String, Map<String, dynamic>>{};

    // Add owned leagues
    for (final league in ownedLeagues) {
      uniqueLeagues[league['id']] = league;
    }

    // Add leagues by creator_id (only if not already added)
    for (final league in ownedLeaguesByCreator) {
      uniqueLeagues[league['id']] = league;
    }

    // Add member leagues
    for (final memberLeague in memberLeagues) {
      if (memberLeague['leagues'] != null) {
        final league = memberLeague['leagues'] as Map<String, dynamic>;
        uniqueLeagues[league['id']] = league;
      }
    }

    final finalLeagues = uniqueLeagues.values.toList();

    print('Total unique leagues found: ${finalLeagues.length}');
    print('Final leagues: $finalLeagues');

    // Convert to League objects - league_members data should now be included
    final List<League> leagues = [];
    final List<String> emptyLeagueIds = [];
    
    for (final data in finalLeagues) {
      final league = _leagueFromSupabase(data);
      print('League ${league.name} (${league.id}) has ${league.memberIds.length} members: ${league.memberIds}');
      
      // Only include leagues that have at least one member
      if (league.memberIds.isNotEmpty) {
        leagues.add(league);
      } else {
        print('Skipping league ${league.name} - no members, will be deleted');
        emptyLeagueIds.add(league.id);
      }
    }
    
    // Clean up empty leagues
    if (emptyLeagueIds.isNotEmpty) {
      print('Deleting ${emptyLeagueIds.length} empty leagues: $emptyLeagueIds');
      await _cleanupEmptyLeagues(emptyLeagueIds);
    }

    print('=== Returning ${leagues.length} leagues to user (filtered out empty leagues) ===');
    return leagues;
  }

  @override
  Future<League> getLeague(String leagueId) async {
    final response = await _supabase
        .from('leagues')
        .select('*, league_members(user_id)')
        .eq('id', leagueId)
        .single();

    final league = _leagueFromSupabase(response);

    // The league_members data should now be included in the response
    print(
      'getLeague - League ${league.name} has ${league.memberIds.length} members',
    );

    return league;
  }

  @override
  Future<void> joinLeagueByCode(String inviteCode) async {
    // This would need to be implemented with invitation system
    throw UnimplementedError('joinLeagueByCode not implemented yet');
  }

  @override
  Future<void> joinPublicLeague(String leagueId) async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      throw Exception('No user logged in');
    }

    await joinLeague(leagueId, currentUser.id);
  }

  @override
  Future<List<League>> listLeagues([String? userId]) async {
    if (userId != null) {
      // Get leagues for a specific user
      return listLeaguesForUser(userId);
    }

    // Get all leagues (for system processing)
    final response = await _supabase.from('leagues').select('*');

    return response.map<League>((data) => _leagueFromSupabase(data)).toList();
  }

  @override
  Stream<List<app_user.User>> leagueMembers(String leagueId) async* {
    await for (final response
        in _supabase
            .from('league_members')
            .stream(primaryKey: ['id'])
            .eq('league_id', leagueId)) {
      // This would need to fetch user details for each member
      // For now, return empty list
      yield <app_user.User>[];
    }
  }

  @override
  Future<List<League>> getPublicLeagues() async {
    final response = await _supabase
        .from('leagues')
        .select('*')
        .eq('visibility', 'public');

    return response.map<League>((data) => _leagueFromSupabase(data)).toList();
  }

  @override
  Future<League?> getLeagueById(String leagueId) async {
    try {
      final response = await _supabase
          .from('leagues')
          .select('*')
          .eq('id', leagueId)
          .single();

      return _leagueFromSupabase(response);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> joinLeague(String leagueId, String userId) async {
    await _supabase.from('league_members').insert({
      'league_id': leagueId,
      'user_id': userId,
      'joined_at': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<void> leaveLeague(String leagueId, String userId) async {
    print('=== leaveLeague called ===');
    print('Removing user $userId from league $leagueId');
    
    // First, check if the user is the owner of the league
    final leagueResponse = await _supabase
        .from('leagues')
        .select('owner_id, creator_id')
        .eq('id', leagueId)
        .single();
    
    final isOwner = leagueResponse['owner_id'] == userId || leagueResponse['creator_id'] == userId;
    print('User is owner: $isOwner');
    
    // Remove user from league_members table
    final result = await _supabase
        .from('league_members')
        .delete()
        .eq('league_id', leagueId)
        .eq('user_id', userId);
    
    print('Leave league result: $result');
    
    // If user is the owner, clear the owner_id and creator_id fields
    if (isOwner) {
      await _supabase
          .from('leagues')
          .update({
            'owner_id': null,
            'creator_id': null,
          })
          .eq('id', leagueId);
      
      print('Cleared owner_id and creator_id for league $leagueId');
    }
    
    print('=== leaveLeague completed ===');
  }

  @override
  Future<void> updateLeague(League league) async {
    await _supabase
        .from('leagues')
        .update({
          'name': league.name,
          'max_losses': league.settings.maxLosses,
          'allow_team_reuse': league.settings.allowTeamReuse,
          'auto_eliminate_on_no_pick': league.settings.autoEliminateOnNoPick,
          'visibility': league.visibility.name,
        })
        .eq('id', league.id);
  }

  @override
  Future<void> deleteLeague(String leagueId) async {
    await _supabase.from('leagues').delete().eq('id', leagueId);
  }

  /// Clean up empty leagues by deleting them from the database
  Future<void> _cleanupEmptyLeagues(List<String> leagueIds) async {
    try {
      // Delete from leagues table
      await _supabase
          .from('leagues')
          .delete()
          .inFilter('id', leagueIds);
      
      print('Successfully deleted ${leagueIds.length} empty leagues');
    } catch (e) {
      print('Error deleting empty leagues: $e');
    }
  }

  League _leagueFromSupabase(Map<String, dynamic> data) {
    // Parse member_points from JSONB
    Map<String, int> memberPoints = {};
    if (data['member_points'] != null) {
      final pointsData = data['member_points'] as Map<String, dynamic>;
      memberPoints = pointsData.map(
        (key, value) => MapEntry(key, (value as num).toInt()),
      );
    }

    // Debug league_members data
    print('League data for ${data['name']}:');
    print('  Raw data keys: ${data.keys.toList()}');
    print('  league_members: ${data['league_members']}');
    if (data['league_members'] != null) {
      print('  league_members type: ${data['league_members'].runtimeType}');
      print(
        '  league_members length: ${(data['league_members'] as List).length}',
      );
      print('  league_members content: ${data['league_members']}');
      print(
        '  memberIds will be: ${(data['league_members'] as List<dynamic>?)?.map((member) => member['user_id'] as String).toList() ?? []}',
      );
    } else {
      print('  No league_members data (will be fetched separately)');
    }

    // Get member IDs from league_members table
    List<String> memberIds = [];
    if (data['league_members'] != null && (data['league_members'] as List).isNotEmpty) {
      memberIds = (data['league_members'] as List<dynamic>)
          .map((member) => member['user_id'] as String)
          .toList();
    }
    // No fallback - if no members, league should be empty

    return League(
      id: data['id'],
      name: data['name'],
      ownerId:
          data['owner_id'] ??
          data['creator_id'], // Fallback to creator_id if owner_id is null
      visibility: LeagueVisibility.values.firstWhere(
        (v) => v.name == data['visibility'],
        orElse: () => LeagueVisibility.PRIVATE,
      ),
      settings: LeagueSettings(
        maxLosses: data['max_losses'],
        allowTeamReuse: data['allow_team_reuse'] ?? true,
        autoEliminateOnNoPick: data['auto_eliminate_on_no_pick'] ?? true,
      ),
      season: data['season'] ?? 2025,
      createdAtIso: data['created_at_iso'] ?? DateTime.now().toIso8601String(),
      memberIds: memberIds,
      inviteCode: data['invite_code'],
      memberPoints: memberPoints,
    );
  }

  // Helper method to get member count for a league
  Future<int> _getMemberCount(String leagueId) async {
    try {
      print('DEBUG: Getting member count for league: $leagueId');
      print('DEBUG: Current user: ${_supabase.auth.currentUser?.id}');

      // Use a simple select and count the results
      final response = await _supabase
          .from('league_members')
          .select('user_id')
          .eq('league_id', leagueId);

      print('DEBUG: Raw response: $response');
      print('DEBUG: Response type: ${response.runtimeType}');
      print('DEBUG: Response length: ${response.length}');

      final count = response.length;
      print(
        'Member count for league $leagueId: $count (from ${response.length} rows)',
      );
      return count;
    } catch (e) {
      print('Error getting member count for league $leagueId: $e');
      print('Error details: ${e.toString()}');
      print('Error type: ${e.runtimeType}');

      // Try a different approach - maybe RLS is blocking us
      try {
        print('DEBUG: Trying alternative query...');
        final altResponse = await _supabase
            .from('league_members')
            .select('*')
            .eq('league_id', leagueId);
        print('DEBUG: Alternative response: $altResponse');
        print('DEBUG: Alternative response length: ${altResponse.length}');
        return altResponse.length;
      } catch (altError) {
        print('DEBUG: Alternative query also failed: $altError');
        return 0;
      }
    }
  }

  // Helper method to get member IDs for a league (for when we actually need them)
  Future<List<String>> _getMemberIds(String leagueId) async {
    try {
      final response = await _supabase
          .from('league_members')
          .select('user_id')
          .eq('league_id', leagueId);

      final memberIds = response
          .map((row) => row['user_id'] as String)
          .toList();
      print(
        'Member IDs for league $leagueId: $memberIds (count: ${memberIds.length})',
      );
      return memberIds;
    } catch (e) {
      print('Error getting member IDs for league $leagueId: $e');
      return [];
    }
  }
}
