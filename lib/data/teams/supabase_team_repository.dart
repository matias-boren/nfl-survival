import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pick1/data/teams/team_repositories.dart';
import 'package:pick1/data/models/team.dart';

class SupabaseTeamRepository implements TeamRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<List<Team>> getAllTeams() async {
    try {
      final response = await _supabase
          .from('teams')
          .select()
          .order('name');

      return response.map((row) => _teamFromSupabase(row)).toList();
    } catch (e) {
      print('Error fetching all teams: $e');
      return [];
    }
  }

  @override
  Future<Team?> getTeamByEspnId(String espnTeamId) async {
    try {
      final response = await _supabase
          .from('teams')
          .select()
          .eq('espn_team_id', espnTeamId)
          .maybeSingle();

      if (response == null) return null;
      return _teamFromSupabase(response);
    } catch (e) {
      print('Error fetching team by ESPN ID: $e');
      return null;
    }
  }

  @override
  Future<Team?> getTeamById(String teamId) async {
    try {
      final response = await _supabase
          .from('teams')
          .select()
          .eq('id', teamId)
          .maybeSingle();

      if (response == null) return null;
      return _teamFromSupabase(response);
    } catch (e) {
      print('Error fetching team by ID: $e');
      return null;
    }
  }

  @override
  Future<List<TeamWithRecord>> getTeamsWithRecords(int season, int week) async {
    try {
      final response = await _supabase
          .from('teams')
          .select('''
            *,
            team_records!left(
              id,
              team_id,
              season,
              week,
              wins,
              losses,
              ties,
              last_updated
            )
          ''')
          .eq('team_records.season', season)
          .eq('team_records.week', week)
          .order('name');

      return response.map((row) => _teamWithRecordFromSupabase(row)).toList();
    } catch (e) {
      print('Error fetching teams with records: $e');
      return [];
    }
  }

  @override
  Future<void> createTeam(Team team) async {
    try {
      await _supabase.from('teams').insert(_teamToSupabase(team));
    } catch (e) {
      print('Error creating team: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateTeam(Team team) async {
    try {
      await _supabase
          .from('teams')
          .update(_teamToSupabase(team))
          .eq('id', team.id);
    } catch (e) {
      print('Error updating team: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTeam(String teamId) async {
    try {
      await _supabase.from('teams').delete().eq('id', teamId);
    } catch (e) {
      print('Error deleting team: $e');
      rethrow;
    }
  }

  Team _teamFromSupabase(Map<String, dynamic> data) {
    return Team(
      id: data['id'],
      espnTeamId: data['espn_team_id'],
      name: data['name'],
      abbreviation: data['abbreviation'],
      city: data['city'],
      conference: data['conference'],
      division: data['division'],
      logoUrl: data['logo_url'],
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }

  TeamWithRecord _teamWithRecordFromSupabase(Map<String, dynamic> data) {
    final team = _teamFromSupabase(data);
    TeamRecord? record;

    if (data['team_records'] != null && data['team_records'].isNotEmpty) {
      final recordData = data['team_records'][0];
      record = TeamRecord(
        id: recordData['id'],
        teamId: recordData['team_id'],
        season: recordData['season'],
        week: recordData['week'],
        wins: recordData['wins'],
        losses: recordData['losses'],
        ties: recordData['ties'],
        lastUpdated: DateTime.parse(recordData['last_updated']),
      );
    }

    return TeamWithRecord(team: team, record: record);
  }

  Map<String, dynamic> _teamToSupabase(Team team) {
    return {
      'id': team.id,
      'espn_team_id': team.espnTeamId,
      'name': team.name,
      'abbreviation': team.abbreviation,
      'city': team.city,
      'conference': team.conference,
      'division': team.division,
      'logo_url': team.logoUrl,
      'created_at': team.createdAt.toIso8601String(),
      'updated_at': team.updatedAt.toIso8601String(),
    };
  }
}
