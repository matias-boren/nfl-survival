import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick1/core/services/result_processing_service.dart';
import 'package:pick1/core/services/standings_service.dart';
import 'package:pick1/data/leagues/league_repositories.dart';
import 'package:pick1/data/models/league.dart';
import 'package:pick1/data/models/nfl.dart';
import 'package:pick1/data/nfl/nfl_repositories.dart';
import 'package:pick1/data/picks/picks_repositories.dart';
import 'package:pick1/data/users/user_repositories.dart';
import 'package:pick1/app/providers.dart';

class WeeklyDataRefreshService {
  static final WeeklyDataRefreshService _instance =
      WeeklyDataRefreshService._internal();
  factory WeeklyDataRefreshService() => _instance;
  WeeklyDataRefreshService._internal();

  Timer? _refreshTimer;
  Timer? _checkTimer;
  bool _isProcessing = false;
  int? _currentProcessingWeek;

  // Dependencies
  LeagueRepository? _leagueRepository;
  NflRepository? _nflRepository;
  ResultProcessingService? _resultProcessingService;
  StandingsService? _standingsService;

  /// Initialize with dependencies
  void initialize({
    required LeagueRepository leagueRepository,
    required NflRepository nflRepository,
    required PicksRepository picksRepository,
    required UserRepository userRepository,
    required ProviderRef ref,
  }) {
    _leagueRepository = leagueRepository;
    _nflRepository = nflRepository;
    _resultProcessingService = ResultProcessingService(
      picksRepository: picksRepository,
      leagueRepository: leagueRepository,
      nflRepository: nflRepository,
      teamService: ref.read(teamServiceProvider),
    );
    _standingsService = StandingsService(
      picksRepository: picksRepository,
      userRepository: userRepository,
    );
  }

  /// Start the automated weekly data refresh service
  void startService() {
    if (_refreshTimer != null) return; // Already running

    print('🔄 Starting Weekly Data Refresh Service...');

    // Check for week transitions every hour
    _checkTimer = Timer.periodic(const Duration(hours: 1), (timer) {
      _checkForWeekTransition();
    });

    // Process results every 30 minutes during active periods
    _refreshTimer = Timer.periodic(const Duration(minutes: 30), (timer) {
      _processCurrentWeekResults();
    });

    // Run initial checks
    _checkForWeekTransition();
    _processCurrentWeekResults();
  }

  /// Stop the automated service
  void stopService() {
    _refreshTimer?.cancel();
    _checkTimer?.cancel();
    _refreshTimer = null;
    _checkTimer = null;
    print('⏹️ Stopped Weekly Data Refresh Service');
  }

  /// Check if we need to transition to a new week
  Future<void> _checkForWeekTransition() async {
    try {
      final currentWeek = await _getCurrentWeek();
      final isWeekComplete = await _isWeekComplete(currentWeek);

      if (isWeekComplete && _currentProcessingWeek != currentWeek) {
        print(
          '📅 Week $currentWeek is complete! Processing results and transitioning...',
        );
        await _processWeekTransition(currentWeek);
      }
    } catch (e) {
      print('❌ Error checking for week transition: $e');
    }
  }

  /// Process current week results (for ongoing games)
  Future<void> _processCurrentWeekResults() async {
    if (_isProcessing) return;

    try {
      final currentWeek = await _getCurrentWeek();
      final completedGames = await _getCompletedGames(currentWeek);

      if (completedGames.isNotEmpty) {
        print(
          '🎯 Processing ${completedGames.length} completed games for week $currentWeek',
        );
        await _processResultsForWeek(currentWeek, completedGames);
      }
    } catch (e) {
      print('❌ Error processing current week results: $e');
    }
  }

  /// Process a complete week transition
  Future<void> _processWeekTransition(int completedWeek) async {
    _isProcessing = true;
    _currentProcessingWeek = completedWeek;

    try {
      print(
        '🚀 Starting week transition processing for week $completedWeek...',
      );

      // 1. Get all completed games for the week
      final completedGames = await _getCompletedGames(completedWeek);
      print('📊 Found ${completedGames.length} completed games');

      // 2. Process all league results
      final allLeagues = await _getAllLeagues();
      print('🏆 Processing ${allLeagues.length} leagues');

      int totalPicksProcessed = 0;
      int totalEliminations = 0;

      for (final league in allLeagues) {
        try {
          final summary = await _resultProcessingService!.processWeekResults(
            leagueId: league.id,
            week: completedWeek,
          );

          totalPicksProcessed += summary.totalPicks;
          totalEliminations += summary.eliminatedUsers.length;

          print(
            '✅ League ${league.name}: ${summary.totalPicks} picks processed, ${summary.eliminatedUsers.length} eliminations',
          );
        } catch (e) {
          print('❌ Error processing league ${league.name}: $e');
        }
      }

      // 3. Update all league standings
      for (final league in allLeagues) {
        try {
          await _updateLeagueStandings(league.id);
        } catch (e) {
          print('❌ Error updating standings for league ${league.name}: $e');
        }
      }

      // 4. Prepare next week's data
      final nextWeek = completedWeek + 1;
      await _prepareNextWeekData(nextWeek);

      print('🎉 Week transition complete!');
      print('📈 Total picks processed: $totalPicksProcessed');
      print('💀 Total eliminations: $totalEliminations');
      print('📅 Next week prepared: $nextWeek');
    } catch (e) {
      print('❌ Error during week transition: $e');
    } finally {
      _isProcessing = false;
    }
  }

  /// Process results for a specific week
  Future<void> _processResultsForWeek(
    int week,
    List<Game> completedGames,
  ) async {
    try {
      final allLeagues = await _getAllLeagues();

      for (final league in allLeagues) {
        try {
          await _resultProcessingService!.processWeekResults(
            leagueId: league.id,
            week: week,
          );
        } catch (e) {
          print('❌ Error processing results for league ${league.id}: $e');
        }
      }
    } catch (e) {
      print('❌ Error processing results for week $week: $e');
    }
  }

  /// Check if a week is complete (all games finished + 12 hours)
  Future<bool> _isWeekComplete(int week) async {
    try {
      final games = await _nflRepository!.listGames(season: 2025, week: week);

      if (games.isEmpty) return false;

      // Check if all games are final
      final allGamesComplete = games.every(
        (game) => game.status == GameStatus.FINAL,
      );

      if (!allGamesComplete) return false;

      // Find the latest game end time
      DateTime? latestGameEnd;
      for (final game in games) {
        // Estimate game end time (3 hours after start for NFL games)
        final estimatedEndTime = game.date.add(const Duration(hours: 3));
        if (latestGameEnd == null || estimatedEndTime.isAfter(latestGameEnd)) {
          latestGameEnd = estimatedEndTime;
        }
      }

      if (latestGameEnd == null) return false;

      // Check if 12 hours have passed since the last game
      final processingTime = latestGameEnd.add(const Duration(hours: 12));
      final now = DateTime.now();

      final isReadyForProcessing = now.isAfter(processingTime);

      print('📅 Week $week completion check:');
      print('   Latest game end: $latestGameEnd');
      print('   Processing time: $processingTime');
      print('   Current time: $now');
      print('   Ready for processing: $isReadyForProcessing');

      return isReadyForProcessing;
    } catch (e) {
      print('❌ Error checking week completion: $e');
      return false;
    }
  }

  /// Get current week
  Future<int> _getCurrentWeek() async {
    try {
      // Get the current week from the NFL repository
      // This should match the logic in your deadline service
      final now = DateTime.now();
      final seasonStart = DateTime(
        now.year,
        9,
        1,
      ); // Approximate NFL season start
      final daysSinceStart = now.difference(seasonStart).inDays;
      final week = (daysSinceStart / 7).floor() + 1;
      return week.clamp(1, 18); // NFL regular season is 18 weeks
    } catch (e) {
      print('❌ Error getting current week: $e');
      return 4; // Fallback
    }
  }

  /// Get completed games for a specific week
  Future<List<Game>> _getCompletedGames(int week) async {
    try {
      final games = await _nflRepository!.listGames(season: 2025, week: week);
      return games.where((game) => game.status == GameStatus.FINAL).toList();
    } catch (e) {
      print('❌ Error getting completed games for week $week: $e');
      return [];
    }
  }

  /// Get all leagues
  Future<List<League>> _getAllLeagues() async {
    try {
      // Get all leagues (no userId parameter means get all leagues)
      return await _leagueRepository!.listLeagues();
    } catch (e) {
      print('❌ Error getting all leagues: $e');
      return [];
    }
  }

  /// Update league standings
  Future<void> _updateLeagueStandings(String leagueId) async {
    try {
      final league = await _leagueRepository!.getLeague(leagueId);
      await _standingsService!.calculateLeagueStandings(
        leagueId: leagueId,
        league: league,
      );
    } catch (e) {
      print('❌ Error updating standings for league $leagueId: $e');
    }
  }

  /// Prepare next week's data (preload games, etc.)
  Future<void> _prepareNextWeekData(int nextWeek) async {
    try {
      print('📋 Preparing data for week $nextWeek...');

      // Preload next week's games
      final nextWeekGames = await _nflRepository!.listGames(
        season: 2025,
        week: nextWeek,
      );
      print('🎮 Preloaded ${nextWeekGames.length} games for week $nextWeek');

      // Any other preparation logic can go here
      // For example: clearing caches, updating UI state, etc.
    } catch (e) {
      print('❌ Error preparing next week data: $e');
    }
  }

  /// Manually trigger week transition (for admin use)
  Future<void> triggerWeekTransition(int week) async {
    print('🔧 Manual week transition triggered for week $week');
    await _processWeekTransition(week);
  }

  /// Get service status
  Map<String, dynamic> getStatus() {
    return {
      'isRunning': _refreshTimer != null,
      'isProcessing': _isProcessing,
      'currentProcessingWeek': _currentProcessingWeek,
      'nextCheckTime': _checkTimer?.isActive == true ? 'Active' : 'Inactive',
      'nextRefreshTime': _refreshTimer?.isActive == true
          ? 'Active'
          : 'Inactive',
    };
  }

  /// Dispose resources
  void dispose() {
    stopService();
  }
}
