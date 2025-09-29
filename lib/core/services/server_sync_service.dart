import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nfl_survival/data/models/nfl.dart';

/// Service that syncs with our backend server instead of polling ESPN directly
class ServerSyncService {
  static final ServerSyncService _instance = ServerSyncService._internal();
  factory ServerSyncService() => _instance;
  ServerSyncService._internal();

  Timer? _timer;
  bool _isRunning = false;
  final StreamController<List<LiveScore>> _scoresController =
      StreamController<List<LiveScore>>.broadcast();

  // Server configuration
  String _serverBaseUrl =
      'https://your-backend-server.com/api'; // Replace with your server
  int _currentWeek = 4;
  int _currentSeason = 2025;

  /// Initialize the service
  void initialize({String? serverBaseUrl, int season = 2025, int week = 4}) {
    if (serverBaseUrl != null) {
      _serverBaseUrl = serverBaseUrl;
    }
    _currentSeason = season;
    _currentWeek = week;
  }

  /// Start syncing with server
  void startSyncing() {
    if (_isRunning) return;

    print('Starting server sync every 15 seconds...');
    _isRunning = true;

    // Sync immediately
    _syncWithServer();

    // Then sync every 15 seconds
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _syncWithServer();
    });
  }

  /// Stop syncing with server
  void stopSyncing() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
    print('Stopped server sync');
  }

  /// Get the live scores stream
  Stream<List<LiveScore>> get scoresStream => _scoresController.stream;

  /// Check if syncing is currently running
  bool get isRunning => _isRunning;

  /// Update the current week/season
  void updateWeek(int week, {int? season}) {
    _currentWeek = week;
    if (season != null) {
      _currentSeason = season;
    }
    print('Updated server sync to week $week, season $_currentSeason');
  }

  /// Sync with server
  Future<void> _syncWithServer() async {
    try {
      print('Syncing with server for week $_currentWeek...');

      // Call our backend API instead of ESPN directly
      final response = await http.get(
        Uri.parse(
          '$_serverBaseUrl/live-scores?week=$_currentWeek&season=$_currentSeason',
        ),
        headers: {
          'Content-Type': 'application/json',
          // Add authentication headers if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final liveScores = _parseServerResponse(data);

        // Check if there are any live games
        final liveGames = liveScores.where((score) => score.isLive).length;
        if (liveGames > 0) {
          print('Found $liveGames live games from server');
        }

        // Emit the scores
        _scoresController.add(liveScores);
      } else {
        print('Server sync failed: ${response.statusCode}');
        // Don't emit error to stream, just log it
      }
    } catch (e) {
      print('Error syncing with server: $e');
      // Don't emit error to stream, just log it
    }
  }

  /// Parse server response
  List<LiveScore> _parseServerResponse(Map<String, dynamic> data) {
    try {
      final List<dynamic> scoresData = data['scores'] ?? [];
      return scoresData
          .map(
            (scoreData) => LiveScore(
              gameId: scoreData['gameId'] ?? '',
              homeTeam: Team(
                id: scoreData['homeTeam']['id'] ?? '',
                name: scoreData['homeTeam']['name'] ?? '',
                abbreviation: scoreData['homeTeam']['abbreviation'] ?? '',
                city: scoreData['homeTeam']['city'] ?? '',
                logoUrl: scoreData['homeTeam']['logoUrl'] ?? '',
                color: scoreData['homeTeam']['color'] ?? '',
                alternateColor: scoreData['homeTeam']['alternateColor'] ?? '',
              ),
              awayTeam: Team(
                id: scoreData['awayTeam']['id'] ?? '',
                name: scoreData['awayTeam']['name'] ?? '',
                abbreviation: scoreData['awayTeam']['abbreviation'] ?? '',
                city: scoreData['awayTeam']['city'] ?? '',
                logoUrl: scoreData['awayTeam']['logoUrl'] ?? '',
                color: scoreData['awayTeam']['color'] ?? '',
                alternateColor: scoreData['awayTeam']['alternateColor'] ?? '',
              ),
              homeScore: scoreData['homeScore'],
              awayScore: scoreData['awayScore'],
              status: scoreData['status'] ?? 'SCHEDULED',
              quarter: scoreData['quarter'] ?? 0,
              timeRemaining: scoreData['timeRemaining'],
              isLive: scoreData['isLive'] ?? false,
              gameDate: DateTime.parse(
                scoreData['gameDate'] ?? DateTime.now().toIso8601String(),
              ),
            ),
          )
          .toList();
    } catch (e) {
      print('Error parsing server response: $e');
      return [];
    }
  }

  /// Get current live scores (one-time fetch)
  Future<List<LiveScore>> getCurrentScores() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_serverBaseUrl/live-scores?week=$_currentWeek&season=$_currentSeason',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return _parseServerResponse(data);
      } else {
        print('Server request failed: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error getting current scores: $e');
      return [];
    }
  }

  /// Dispose resources
  void dispose() {
    stopSyncing();
    _scoresController.close();
  }
}
