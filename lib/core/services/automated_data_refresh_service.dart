import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pick1/core/services/result_processing_service.dart';
import 'package:pick1/core/services/team_service.dart';
import 'package:pick1/data/leagues/league_repositories.dart';
import 'package:pick1/data/nfl/nfl_repositories.dart';

class AutomatedDataRefreshService {
  static final AutomatedDataRefreshService _instance = AutomatedDataRefreshService._internal();
  factory AutomatedDataRefreshService() => _instance;
  AutomatedDataRefreshService._internal();

  Timer? _refreshTimer;
  bool _isRunning = false;
  final http.Client _client = http.Client();

  // Dependencies (will be injected)
  ResultProcessingService? _resultProcessingService;
  TeamService? _teamService;
  LeagueRepository? _leagueRepository;
  NflRepository? _nflRepository;

  /// Initialize the service with dependencies
  void initialize({
    required ResultProcessingService resultProcessingService,
    required TeamService teamService,
    required LeagueRepository leagueRepository,
    required NflRepository nflRepository,
  }) {
    _resultProcessingService = resultProcessingService;
    _teamService = teamService;
    _leagueRepository = leagueRepository;
    _nflRepository = nflRepository;
  }

  /// Start the automated refresh service
  void startService() {
    if (_isRunning) {
      print('🔄 AutomatedDataRefreshService already running');
      return;
    }

    print('🚀 Starting AutomatedDataRefreshService');
    _isRunning = true;

    // Check immediately on start
    _checkAndProcessResults();

    // Then check every 30 minutes
    _refreshTimer = Timer.periodic(const Duration(minutes: 30), (timer) {
      _checkAndProcessResults();
    });
  }

  /// Stop the automated refresh service
  void stopService() {
    print('🛑 Stopping AutomatedDataRefreshService');
    _refreshTimer?.cancel();
    _refreshTimer = null;
    _isRunning = false;
  }

  /// Check if we should process results and do it
  Future<void> _checkAndProcessResults() async {
    try {
      print('🔍 Checking if we should process results...');
      
      // Get current week info from ESPN API
      final weekInfo = await _getCurrentWeekInfo();
      if (weekInfo == null) {
        print('❌ Could not get week info from ESPN API');
        return;
      }

      final currentWeek = weekInfo['week'];
      final season = weekInfo['season'];
      final endDate = weekInfo['endDate'];
      
      print('📅 Current week: $currentWeek, Season: $season');
      print('⏰ Week end date: $endDate');

      // Check if we're within 6 hours of the week end
      final shouldProcess = _shouldProcessResults(endDate);
      if (!shouldProcess) {
        print('⏳ Not yet time to process results (6+ hours before week end)');
        return;
      }

      print('✅ Time to process results! Running data refresh...');
      await _processWeekResults(currentWeek, season);

    } catch (e) {
      print('❌ Error in automated data refresh: $e');
    }
  }

  /// Get current week information from ESPN API
  Future<Map<String, dynamic>?> _getCurrentWeekInfo() async {
    try {
      final response = await _client.get(
        Uri.parse('https://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard'),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        },
      );

      if (response.statusCode != 200) {
        print('❌ ESPN API returned status: ${response.statusCode}');
        return null;
      }

      final data = json.decode(response.body);
      final week = data['week']?['number'];
      final season = data['season']?['year'];
      final endDate = data['week']?['endDate'];

      if (week == null || season == null || endDate == null) {
        print('❌ Missing week/season/endDate in ESPN API response');
        return null;
      }

      return {
        'week': week,
        'season': season,
        'endDate': endDate,
      };
    } catch (e) {
      print('❌ Error fetching week info from ESPN API: $e');
      return null;
    }
  }

  /// Check if we should process results (within 6 hours of week end)
  bool _shouldProcessResults(String endDateString) {
    try {
      final endDate = DateTime.parse(endDateString);
      final now = DateTime.now().toUtc();
      final sixHoursBefore = endDate.subtract(const Duration(hours: 6));
      
      print('🕐 Current time: $now');
      print('🕐 6 hours before week end: $sixHoursBefore');
      print('🕐 Week end: $endDate');
      
      final shouldProcess = now.isAfter(sixHoursBefore);
      print('🤔 Should process results: $shouldProcess');
      
      return shouldProcess;
    } catch (e) {
      print('❌ Error parsing endDate: $e');
      return false;
    }
  }

  /// Process results for the current week
  Future<void> _processWeekResults(int week, int season) async {
    if (_resultProcessingService == null || _leagueRepository == null) {
      print('❌ Dependencies not initialized');
      return;
    }

    try {
      print('🏈 Processing results for Week $week, Season $season');

      // Get all leagues
      final leagues = await _leagueRepository!.listLeagues();
      print('📊 Found ${leagues.length} leagues to process');

      // Process results for each league
      for (final league in leagues) {
        try {
          print('🏆 Processing league: ${league.name} (${league.id})');
          
          final summary = await _resultProcessingService!.processWeekResults(
            leagueId: league.id,
            week: week,
          );

          print('✅ League ${league.name} processed:');
          print('   - Total picks: ${summary.totalPicks}');
          print('   - Processed picks: ${summary.processedPicks.length}');
          print('   - Eliminated users: ${summary.eliminatedUsers.length}');
          print('   - Completed games: ${summary.completedGames}');

        } catch (e) {
          print('❌ Error processing league ${league.name}: $e');
        }
      }

      print('🎉 All leagues processed successfully!');

    } catch (e) {
      print('❌ Error processing week results: $e');
    }
  }

  /// Manually trigger result processing (for testing)
  Future<void> processResultsManually() async {
    print('🔧 Manual result processing triggered');
    await _checkAndProcessResults();
  }

  /// Get service status
  bool get isRunning => _isRunning;

  /// Dispose resources
  void dispose() {
    stopService();
    _client.close();
  }
}
