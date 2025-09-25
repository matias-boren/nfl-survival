import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nfl_survival/data/leagues/league_repositories.dart';
import 'package:nfl_survival/data/models/league.dart';

class SupabaseLeagueRepository implements LeagueRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<League> createLeague({
    required String name,
    required String description,
    required int maxLosses,
    required int maxUsers,
    required LeagueVisibility visibility,
    required String creatorId,
  }) async {
    final response = await _supabase
        .from('leagues')
        .insert({
          'name': name,
          'description': description,
          'max_losses': maxLosses,
          'max_users': maxUsers,
          'visibility': visibility.name,
          'creator_id': creatorId,
          'created_at': DateTime.now().toIso8601String(),
        })
        .select()
        .single();

    return _leagueFromSupabase(response);
  }

  @override
  Future<List<League>> getUserLeagues(String userId) async {
    final response = await _supabase
        .from('leagues')
        .select('*, league_members!inner(*)')
        .eq('league_members.user_id', userId);

    return response.map<League>((data) => _leagueFromSupabase(data)).toList();
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
    await _supabase
        .from('league_members')
        .delete()
        .eq('league_id', leagueId)
        .eq('user_id', userId);
  }

  @override
  Future<void> updateLeague(League league) async {
    await _supabase
        .from('leagues')
        .update({
          'name': league.name,
          'description': league.description,
          'max_losses': league.settings.maxLosses,
          'max_users': league.settings.maxUsers,
          'visibility': league.visibility.name,
        })
        .eq('id', league.id);
  }

  @override
  Future<void> deleteLeague(String leagueId) async {
    await _supabase.from('leagues').delete().eq('id', leagueId);
  }

  League _leagueFromSupabase(Map<String, dynamic> data) {
    return League(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      creatorId: data['creator_id'],
      createdAt: DateTime.parse(data['created_at']),
      visibility: LeagueVisibility.values.firstWhere(
        (v) => v.name == data['visibility'],
        orElse: () => LeagueVisibility.private,
      ),
      settings: LeagueSettings(
        maxLosses: data['max_losses'],
        maxUsers: data['max_users'],
      ),
      memberIds: (data['league_members'] as List<dynamic>?)
          ?.map((member) => member['user_id'] as String)
          .toList() ?? [],
    );
  }
}
