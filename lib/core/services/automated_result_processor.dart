import 'dart:async';
import 'package:nfl_survival/core/services/result_processing_service.dart';
import 'package:nfl_survival/data/leagues/league_repositories.dart';
import 'package:nfl_survival/data/models/league.dart';
import 'package:nfl_survival/data/models/nfl.dart';
import 'package:nfl_survival/data/nfl/nfl_repositories.dart';
import 'package:nfl_survival/data/picks/picks_repositories.dart';

class AutomatedResultProcessor {
  static final AutomatedResultProcessor _instance =
      AutomatedResultProcessor._internal();
  factory AutomatedResultProcessor() => _instance;
  AutomatedResultProcessor._internal();

  Timer? _timer;
  bool _isProcessing = false;
  final List<String> _processedGames = [];

  // Public getters for monitoring
  Timer? get timer => _timer;
  bool get isProcessing => _isProcessing;
  List<String> get processedGames => List.from(_processedGames);

  // Dependencies
  LeagueRepository? _leagueRepository;
  NflRepository? _nflRepository;
  PicksRepository? _picksRepository;
  ResultProcessingService? _resultProcessingService;

  /// Initialize with dependencies
  void initialize({
    required LeagueRepository leagueRepository,
    required NflRepository nflRepository,
    required PicksRepository picksRepository,
  }) {
    _leagueRepository = leagueRepository;
    _nflRepository = nflRepository;
    _picksRepository = picksRepository;
    _resultProcessingService = ResultProcessingService(
      picksRepository: picksRepository,
      leagueRepository: leagueRepository,
      nflRepository: nflRepository,
    );
  }

  /// Start automated result processing
  /// Runs every 15 minutes during NFL season
  void startProcessing() {
    if (_timer != null) return; // Already running
    if (_leagueRepository == null ||
        _nflRepository == null ||
        _picksRepository == null) {
      print(
        'AutomatedResultProcessor not initialized. Call initialize() first.',
      );
      return;
    }

    print('Starting automated result processing...');

    _timer = Timer.periodic(const Duration(minutes: 15), (timer) {
      _processAllLeagues();
    });

    // Also run immediately
    _processAllLeagues();
  }

  /// Stop automated result processing
  void stopProcessing() {
    _timer?.cancel();
    _timer = null;
    print('Stopped automated result processing');
  }

  /// Manually trigger processing (for admin use)
  Future<void> processNow() async {
    await _processAllLeagues();
  }

  /// Process results for all leagues
  Future<void> _processAllLeagues() async {
    if (_isProcessing) {
      print('Result processing already in progress, skipping...');
      return;
    }

    _isProcessing = true;
    print('Starting automated result processing for all leagues...');

    try {
      // Get all leagues (we'll need to add this method to LeagueRepository)
      final allLeagues = await _getAllLeagues();

      if (allLeagues.isEmpty) {
        print('No leagues found for result processing');
        return;
      }

      print('Found ${allLeagues.length} leagues to process');

      // Get current week
      final currentWeek = await _getCurrentWeek();
      print('Processing results for week $currentWeek');

      // Get completed games for current week
      final completedGames = await _getCompletedGames(currentWeek);

      if (completedGames.isEmpty) {
        print('No completed games found for week $currentWeek');
        return;
      }

      print('Found ${completedGames.length} completed games');

      // Process each league
      int totalProcessed = 0;
      int totalEliminated = 0;

      for (final league in allLeagues) {
        try {
          print('Processing league: ${league.name} (${league.id})');

          final summary = await _processLeagueResults(
            league,
            currentWeek,
            completedGames,
          );

          totalProcessed += summary.totalPicks;
          totalEliminated += summary.eliminatedUsers.length;

          print(
            'League ${league.name}: ${summary.totalPicks} picks processed, ${summary.eliminatedUsers.length} users eliminated',
          );
        } catch (e) {
          print('Error processing league ${league.name}: $e');
        }
      }

      print(
        'Automated processing complete: $totalProcessed picks processed, $totalEliminated users eliminated',
      );
    } catch (e) {
      print('Error in automated result processing: $e');
    } finally {
      _isProcessing = false;
    }
  }

  /// Get all leagues
  Future<List<League>> _getAllLeagues() async {
    if (_leagueRepository == null) return [];

    try {
      // For now, we'll get leagues from the mock repository
      // In production, this would be a proper database query
      return await _leagueRepository!.listLeagues();
    } catch (e) {
      print('Error fetching leagues: $e');
      return [];
    }
  }

  /// Get current week from NFL repository
  Future<int> _getCurrentWeek() async {
    if (_nflRepository == null) return 4;

    try {
      // Get current week by checking the deadline service logic
      // For now, we'll use a simple approach
      return 4; // This would be calculated based on current date
    } catch (e) {
      print('Error getting current week: $e');
      return 4;
    }
  }

  /// Get completed games for a specific week
  Future<List<Game>> _getCompletedGames(int week) async {
    if (_nflRepository == null) return [];

    try {
      final games = await _nflRepository!.listGames(season: 2025, week: week);

      // Filter for completed games that haven't been processed yet
      final completedGames = games
          .where(
            (game) =>
                game.status == GameStatus.FINAL &&
                !_hasGameBeenProcessed(game.id),
          )
          .toList();

      return completedGames;
    } catch (e) {
      print('Error fetching completed games: $e');
      return [];
    }
  }

  /// Process results for a specific league
  Future<ResultProcessingSummary> _processLeagueResults(
    League league,
    int week,
    List<Game> completedGames,
  ) async {
    if (_resultProcessingService == null) {
      return ResultProcessingSummary(
        leagueId: league.id,
        week: week,
        totalPicks: 0,
        processedPicks: [],
        eliminatedUsers: [],
        completedGames: 0,
      );
    }

    try {
      final summary = await _resultProcessingService!.processWeekResults(
        leagueId: league.id,
        week: week,
      );

      // Mark games as processed
      for (final game in completedGames) {
        _markGameAsProcessed(game.id);
      }

      return summary;
    } catch (e) {
      print('Error processing league ${league.name}: $e');
      return ResultProcessingSummary(
        leagueId: league.id,
        week: week,
        totalPicks: 0,
        processedPicks: [],
        eliminatedUsers: [],
        completedGames: 0,
      );
    }
  }

  /// Check if a game has been processed
  bool _hasGameBeenProcessed(String gameId) {
    return _processedGames.contains(gameId);
  }

  /// Mark a game as processed
  void _markGameAsProcessed(String gameId) {
    _processedGames.add(gameId);
  }

  /// Clear processed games list (call at start of new week)
  void _clearProcessedGames() {
    _processedGames.clear();
  }

  /// Dispose resources
  void dispose() {
    stopProcessing();
  }
}
