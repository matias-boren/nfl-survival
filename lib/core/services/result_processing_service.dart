import 'package:pick1/data/models/pick.dart';
import 'package:pick1/data/models/league.dart';
import 'package:pick1/data/models/nfl.dart';
import 'package:pick1/data/picks/picks_repositories.dart';
import 'package:pick1/data/leagues/league_repositories.dart';
import 'package:pick1/data/nfl/nfl_repositories.dart';
import 'package:pick1/core/services/points_calculation_service.dart';

class ResultProcessingService {
  final PicksRepository _picksRepository;
  final LeagueRepository _leagueRepository;
  final NflRepository _nflRepository;

  ResultProcessingService({
    required PicksRepository picksRepository,
    required LeagueRepository leagueRepository,
    required NflRepository nflRepository,
  }) : _picksRepository = picksRepository,
       _leagueRepository = leagueRepository,
       _nflRepository = nflRepository;

  /// Process results for a specific week and league
  Future<ResultProcessingSummary> processWeekResults({
    required String leagueId,
    required int week,
  }) async {
    print('Processing results for league $leagueId, week $week');

    // Get league settings
    final league = await _leagueRepository.getLeague(leagueId);

    // Get all picks for this week
    final picks = await _picksRepository.listPicks(leagueId, week);
    print('Found ${picks.length} picks for week $week');

    // Get game results for this week
    final games = await _nflRepository.listGames(
      season: league.season,
      week: week,
    );
    print('Found ${games.length} games for week $week');

    // Create a map of game results for quick lookup
    final gameResults = <String, GameResult>{};
    for (final game in games) {
      if (game.status == GameStatus.FINAL) {
        gameResults[game.id] = GameResult(
          gameId: game.id,
          homeTeam: game.homeTeam.abbreviation,
          awayTeam: game.awayTeam.abbreviation,
          homeScore: game.homeScore,
          awayScore: game.awayScore,
          winner: _determineWinner(game),
        );
      }
    }

    print('Found ${gameResults.length} completed games');

    // Process each pick
    final processedPicks = <ProcessedPick>[];
    final eliminatedUsers = <String>[];

    for (final pick in picks) {
      final pickResult = await _processPickResult(
        pick: pick,
        gameResults: gameResults,
        league: league,
      );

      processedPicks.add(pickResult);

      // Check if user should be eliminated
      if (pickResult.shouldEliminate) {
        eliminatedUsers.add(pick.userId);
      }
    }

    // Update pick results in the database
    for (final processedPick in processedPicks) {
      await _picksRepository.updatePickResult(
        pickId: processedPick.pick.id,
        result: processedPick.pickResult,
      );
    }

    // Mark eliminated users in the league
    for (final userId in eliminatedUsers) {
      await _markUserAsEliminated(leagueId, userId);
    }

    // Calculate and update points for the league
    // For now, we'll calculate points for each individual game result
    Map<String, int> updatedPoints = Map.from(league.memberPoints);

    for (final gameResult in gameResults.values) {
      final gamePicks = picks
          .where(
            (pick) =>
                pick.teamId == gameResult.homeTeam ||
                pick.teamId == gameResult.awayTeam,
          )
          .toList();

      if (gamePicks.isNotEmpty) {
        final gamePoints = PointsCalculationService.updateLeaguePoints(
          currentPoints: updatedPoints,
          picks: gamePicks,
          homeScore: gameResult.homeScore,
          awayScore: gameResult.awayScore,
          homeTeam: gameResult.homeTeam,
          awayTeam: gameResult.awayTeam,
        );
        updatedPoints = gamePoints;
      }
    }

    // Update league with new points
    final updatedLeague = league.copyWith(memberPoints: updatedPoints);
    await _leagueRepository.updateLeague(updatedLeague);

    return ResultProcessingSummary(
      leagueId: leagueId,
      week: week,
      totalPicks: picks.length,
      processedPicks: processedPicks,
      eliminatedUsers: eliminatedUsers,
      completedGames: gameResults.length,
    );
  }

  /// Process results for all active leagues for a specific week
  Future<List<ResultProcessingSummary>> processAllLeaguesForWeek(
    int week,
  ) async {
    // This would typically get all active leagues
    // For now, we'll process the leagues that have picks for this week
    final summaries = <ResultProcessingSummary>[];

    // Get all leagues (in a real app, you'd filter for active leagues)
    final leagues = await _leagueRepository.listLeagues();

    for (final league in leagues) {
      try {
        final summary = await processWeekResults(
          leagueId: league.id,
          week: week,
        );
        summaries.add(summary);
      } catch (e) {
        print('Error processing results for league ${league.id}: $e');
      }
    }

    return summaries;
  }

  Future<ProcessedPick> _processPickResult({
    required Pick pick,
    required Map<String, GameResult> gameResults,
    required League league,
  }) async {
    // Find the game this pick was for
    final gameResult = gameResults.values.firstWhere(
      (result) =>
          result.homeTeam == pick.teamId || result.awayTeam == pick.teamId,
      orElse: () =>
          throw Exception('Game result not found for pick ${pick.teamId}'),
    );

    // Determine if the pick won or lost
    final pickResult = _determinePickResult(pick, gameResult);

    // Check if user should be eliminated based on league rules
    final shouldEliminate = await _shouldEliminateUser(
      userId: pick.userId,
      leagueId: pick.leagueId,
      pickResult: pickResult,
      league: league,
    );

    return ProcessedPick(
      pick: pick.copyWith(result: pickResult),
      pickResult: pickResult,
      gameResult: gameResult,
      shouldEliminate: shouldEliminate,
    );
  }

  PickResult _determinePickResult(Pick pick, GameResult gameResult) {
    // NFL games always have a winner after overtime
    if (pick.teamId == gameResult.winner) {
      return PickResult.WIN;
    } else {
      return PickResult.LOSE;
    }
  }

  String? _determineWinner(Game game) {
    if (game.status != GameStatus.FINAL) return null;

    if (game.homeScore > game.awayScore) {
      return game.homeTeam.abbreviation;
    } else {
      return game.awayTeam.abbreviation;
    }
  }

  Future<bool> _shouldEliminateUser({
    required String userId,
    required String leagueId,
    required PickResult pickResult,
    required League league,
  }) async {
    // Get user's current record
    final userPicks = await _picksRepository.getUserPicksForLeague(
      userId,
      leagueId,
    );
    final losses = userPicks
        .where((pick) => pick.result == PickResult.LOSE)
        .length;

    // Add current pick result to losses count
    final totalLosses = losses + (pickResult == PickResult.LOSE ? 1 : 0);

    // Check if user exceeds max losses
    if (totalLosses > league.settings.maxLosses) {
      return true;
    }

    // Check auto-eliminate on no pick rule
    if (league.settings.autoEliminateOnNoPick &&
        pickResult == PickResult.PENDING) {
      return true;
    }

    return false;
  }

  /// Mark a user as eliminated in the league
  Future<void> _markUserAsEliminated(String leagueId, String userId) async {
    try {
      final league = await _leagueRepository.getLeague(leagueId);
      
      // Update the eliminated users map
      final updatedEliminatedUsers = Map<String, bool>.from(league.eliminatedUsers);
      updatedEliminatedUsers[userId] = true;
      
      // Update the league
      final updatedLeague = league.copyWith(
        eliminatedUsers: updatedEliminatedUsers,
      );
      
      await _leagueRepository.updateLeague(updatedLeague);
      print('Marked user $userId as eliminated from league $leagueId');
    } catch (e) {
      print('Error marking user as eliminated: $e');
      rethrow;
    }
  }
}

class GameResult {
  final String gameId;
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;
  final String? winner; // null for ties

  GameResult({
    required this.gameId,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.winner,
  });
}

class ProcessedPick {
  final Pick pick;
  final PickResult pickResult;
  final GameResult gameResult;
  final bool shouldEliminate;

  ProcessedPick({
    required this.pick,
    required this.pickResult,
    required this.gameResult,
    required this.shouldEliminate,
  });
}

class ResultProcessingSummary {
  final String leagueId;
  final int week;
  final int totalPicks;
  final List<ProcessedPick> processedPicks;
  final List<String> eliminatedUsers;
  final int completedGames;

  ResultProcessingSummary({
    required this.leagueId,
    required this.week,
    required this.totalPicks,
    required this.processedPicks,
    required this.eliminatedUsers,
    required this.completedGames,
  });
}
