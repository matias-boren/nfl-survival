import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pick1/data/picks/picks_repositories.dart';
import 'package:pick1/data/models/pick.dart';

class SupabasePicksRepository implements PicksRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<Pick> submitPick({
    required String leagueId,
    required String userId,
    required int week,
    required String teamId,
  }) async {
    // Check if user already has a pick for this week in this league
    final existingPicks = await _supabase
        .from('picks')
        .select('id')
        .eq('user_id', userId)
        .eq('league_id', leagueId)
        .eq('week', week);

    final now = DateTime.now().toIso8601String();

    if (existingPicks.isNotEmpty) {
      // Update existing pick
      await _supabase
          .from('picks')
          .update({'team_id': teamId, 'updated_at': now})
          .eq('user_id', userId)
          .eq('league_id', leagueId)
          .eq('week', week);

      // Return the updated pick
      return Pick(
        id: existingPicks.first['id'],
        leagueId: leagueId,
        userId: userId,
        week: week,
        teamId: teamId,
        madeAtIso: now,
        locked: false,
        result: PickResult.PENDING,
      );
    } else {
      // Create new pick
      final response = await _supabase
          .from('picks')
          .insert({
            'user_id': userId,
            'league_id': leagueId,
            'team_id': teamId,
            'week': week,
            'result': PickResult.PENDING.name,
            'created_at': now,
            'updated_at': now,
          })
          .select()
          .single();

      return Pick(
        id: response['id'],
        leagueId: leagueId,
        userId: userId,
        week: week,
        teamId: teamId,
        madeAtIso: now,
        locked: false,
        result: PickResult.PENDING,
      );
    }
  }

  @override
  Future<Pick?> getUserPick(String leagueId, String userId, int week) async {
    try {
      final response = await _supabase
          .from('picks')
          .select('*')
          .eq('user_id', userId)
          .eq('league_id', leagueId)
          .eq('week', week)
          .maybeSingle();

      if (response == null) return null;

      return Pick(
        id: response['id'],
        leagueId: response['league_id'],
        userId: response['user_id'],
        week: response['week'],
        teamId: response['team_id'],
        madeAtIso: response['created_at'],
        locked: false,
        result: PickResult.values.firstWhere(
          (r) => r.name == response['result'],
          orElse: () => PickResult.PENDING,
        ),
      );
    } catch (e) {
      print('Error getting user pick: $e');
      return null;
    }
  }

  @override
  Future<List<Pick>> listPicks(String leagueId, int week) async {
    try {
      final response = await _supabase
          .from('picks')
          .select('*')
          .eq('league_id', leagueId)
          .eq('week', week);

      return response
          .map<Pick>(
            (data) => Pick(
              id: data['id'],
              leagueId: data['league_id'],
              userId: data['user_id'],
              week: data['week'],
              teamId: data['team_id'],
              madeAtIso: data['created_at'],
              locked: false,
              result: PickResult.values.firstWhere(
                (r) => r.name == data['result'],
                orElse: () => PickResult.PENDING,
              ),
            ),
          )
          .toList();
    } catch (e) {
      print('Error listing picks: $e');
      return [];
    }
  }

  @override
  Future<List<Pick>> getUserPicksForLeague(
    String userId,
    String leagueId,
  ) async {
    try {
      final response = await _supabase
          .from('picks')
          .select('*')
          .eq('league_id', leagueId)
          .eq('user_id', userId)
          .order('week');

      return response
          .map<Pick>(
            (data) => Pick(
              id: data['id'],
              leagueId: data['league_id'],
              userId: data['user_id'],
              week: data['week'],
              teamId: data['team_id'],
              madeAtIso: data['created_at'],
              locked: false,
              result: PickResult.values.firstWhere(
                (r) => r.name == data['result'],
                orElse: () => PickResult.PENDING,
              ),
            ),
          )
          .toList();
    } catch (e) {
      print('Error getting user picks for league: $e');
      return [];
    }
  }

  @override
  Future<List<Pick>> getLeaguePicks(String leagueId) async {
    try {
      final response = await _supabase
          .from('picks')
          .select('*')
          .eq('league_id', leagueId)
          .order('week');

      return response
          .map<Pick>(
            (data) => Pick(
              id: data['id'],
              leagueId: data['league_id'],
              userId: data['user_id'],
              week: data['week'],
              teamId: data['team_id'],
              madeAtIso: data['created_at'],
              locked: false,
              result: PickResult.values.firstWhere(
                (r) => r.name == data['result'],
                orElse: () => PickResult.PENDING,
              ),
            ),
          )
          .toList();
    } catch (e) {
      print('Error getting league picks: $e');
      return [];
    }
  }

  @override
  Future<void> updatePickResult({
    required String pickId,
    required PickResult result,
  }) async {
    await _supabase
        .from('picks')
        .update({
          'result': result.name,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', pickId);
  }

  @override
  Future<bool> canUserSubmitPick({
    required String leagueId,
    required String userId,
    required int week,
  }) async {
    try {
      // Check if user is eliminated from the league
      final leagueResponse = await _supabase
          .from('leagues')
          .select('eliminated_users')
          .eq('id', leagueId)
          .single();

      final eliminatedUsers = Map<String, bool>.from(
        leagueResponse['eliminated_users'] ?? {},
      );

      // If user is marked as eliminated, they cannot submit picks
      if (eliminatedUsers[userId] == true) {
        return false;
      }

      // Additional checks could be added here (e.g., deadline passed, already picked)
      return true;
    } catch (e) {
      print('Error checking if user can submit pick: $e');
      return false; // Default to not allowing if there's an error
    }
  }
}
