import 'package:pick1/data/models/team.dart';

abstract class TeamRepository {
  Future<List<Team>> getAllTeams();
  Future<Team?> getTeamByEspnId(String espnTeamId);
  Future<Team?> getTeamById(String teamId);
  Future<List<TeamWithRecord>> getTeamsWithRecords(int season, int week);
  Future<void> createTeam(Team team);
  Future<void> updateTeam(Team team);
  Future<void> deleteTeam(String teamId);
}

abstract class TeamRecordRepository {
  Future<List<TeamRecord>> getTeamRecords(int season, int week);
  Future<TeamRecord?> getTeamRecord(String teamId, int season, int week);
  Future<List<TeamRecord>> getTeamRecordHistory(String teamId, int season);
  Future<void> createTeamRecord(TeamRecord record);
  Future<void> updateTeamRecord(TeamRecord record);
  Future<void> deleteTeamRecord(String recordId);
  Future<void> updateTeamRecordFromGameResult({
    required String teamId,
    required int season,
    required int week,
    required bool won,
    required bool tied,
  });
}
