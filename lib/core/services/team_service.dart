import 'package:pick1/data/models/team.dart';
import 'package:pick1/data/teams/team_repositories.dart';
import 'package:pick1/data/nfl/nfl_repositories.dart';

class TeamService {
  final TeamRepository _teamRepository;
  final TeamRecordRepository _teamRecordRepository;
  final NflRepository _nflRepository;

  TeamService({
    required TeamRepository teamRepository,
    required TeamRecordRepository teamRecordRepository,
    required NflRepository nflRepository,
  })  : _teamRepository = teamRepository,
        _teamRecordRepository = teamRecordRepository,
        _nflRepository = nflRepository;

  /// Get all teams with their current records
  Future<List<TeamWithRecord>> getTeamsWithRecords({
    required int season,
    required int week,
  }) async {
    return await _teamRepository.getTeamsWithRecords(season, week);
  }

  /// Get a specific team with its record
  Future<TeamWithRecord?> getTeamWithRecord({
    required String teamId,
    required int season,
    required int week,
  }) async {
    final team = await _teamRepository.getTeamById(teamId);
    if (team == null) return null;

    final record = await _teamRecordRepository.getTeamRecord(teamId, season, week);
    return TeamWithRecord(team: team, record: record);
  }

  /// Get team's recent form (last 5 games)
  Future<List<String>> getTeamRecentForm({
    required String teamId,
    required int season,
  }) async {
    try {
      final recordHistory = await _teamRecordRepository.getTeamRecordHistory(teamId, season);
      
      if (recordHistory.isEmpty) return [];

      // Get the last 5 weeks of records
      final recentRecords = recordHistory.take(5).toList();
      final form = <String>[];

      for (int i = 0; i < recentRecords.length - 1; i++) {
        final current = recentRecords[i];
        final previous = recentRecords[i + 1];
        
        // Calculate wins/losses for this week
        final weekWins = current.wins - previous.wins;
        final weekLosses = current.losses - previous.losses;
        final weekTies = current.ties - previous.ties;

        if (weekWins > 0) {
          form.add('W');
        } else if (weekLosses > 0) {
          form.add('L');
        } else if (weekTies > 0) {
          form.add('T');
        }
      }

      return form.reversed.toList(); // Most recent first
    } catch (e) {
      print('Error getting team recent form: $e');
      return [];
    }
  }

  /// Update team records from game results
  Future<void> updateTeamRecordsFromGames({
    required int season,
    required int week,
  }) async {
    try {
      // Get all games for the week
      final games = await _nflRepository.listGames(season: season, week: week);
      
      for (final game in games) {
        if (game.status != GameStatus.FINAL) continue;

        // Determine winner/loser
        final homeScore = int.tryParse(game.homeScore ?? '0') ?? 0;
        final awayScore = int.tryParse(game.awayScore ?? '0') ?? 0;

        if (homeScore > awayScore) {
          // Home team won
          await _teamRecordRepository.updateTeamRecordFromGameResult(
            teamId: game.homeTeamId,
            season: season,
            week: week,
            won: true,
            tied: false,
          );
          await _teamRecordRepository.updateTeamRecordFromGameResult(
            teamId: game.awayTeamId,
            season: season,
            week: week,
            won: false,
            tied: false,
          );
        } else if (awayScore > homeScore) {
          // Away team won
          await _teamRecordRepository.updateTeamRecordFromGameResult(
            teamId: game.awayTeamId,
            season: season,
            week: week,
            won: true,
            tied: false,
          );
          await _teamRecordRepository.updateTeamRecordFromGameResult(
            teamId: game.homeTeamId,
            season: season,
            week: week,
            won: false,
            tied: false,
          );
        } else {
          // Tie
          await _teamRecordRepository.updateTeamRecordFromGameResult(
            teamId: game.homeTeamId,
            season: season,
            week: week,
            won: false,
            tied: true,
          );
          await _teamRecordRepository.updateTeamRecordFromGameResult(
            teamId: game.awayTeamId,
            season: season,
            week: week,
            won: false,
            tied: true,
          );
        }
      }
    } catch (e) {
      print('Error updating team records from games: $e');
      rethrow;
    }
  }

  /// Format team record for display
  String formatTeamRecord(TeamRecord? record) {
    if (record == null) return '0-0';
    return '${record.wins}-${record.losses}';
  }

  /// Get record color based on wins/losses
  String getRecordColor(TeamRecord? record) {
    if (record == null) return '#6B7280'; // Gray for no record
    
    final winPercentage = record.wins / (record.wins + record.losses + record.ties);
    
    if (winPercentage >= 0.6) {
      return '#255F38'; // Green for good record
    } else if (winPercentage <= 0.4) {
      return '#F7374F'; // Red for poor record
    } else {
      return '#6B7280'; // Gray for average record
    }
  }

  /// Format recent form for display
  String formatRecentForm(List<String> form) {
    if (form.isEmpty) return '';
    return form.join('-');
  }
}
