import 'dart:async';
import 'package:nfl_survival/data/models/nfl.dart';
import 'package:nfl_survival/data/nfl/nfl_repositories.dart';

class LiveScoresService {
  static final LiveScoresService _instance = LiveScoresService._internal();
  factory LiveScoresService() => _instance;
  LiveScoresService._internal();

  Timer? _timer;
  bool _isRunning = false;
  final StreamController<List<LiveScore>> _scoresController =
      StreamController<List<LiveScore>>.broadcast();

  // Dependencies
  NflRepository? _nflRepository;
  int _currentWeek = 4;
  int _currentSeason = 2025;

  /// Initialize the service with dependencies
  void initialize({
    required NflRepository nflRepository,
    int season = 2025,
    int week = 4,
  }) {
    _nflRepository = nflRepository;
    _currentSeason = season;
    _currentWeek = week;
  }

  /// Start real-time live scores polling
  void startPolling() {
    if (_isRunning) return;

    print('Starting live scores polling every 15 seconds...');
    _isRunning = true;

    // Poll immediately
    _pollScores();

    // Then poll every 15 seconds
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _pollScores();
    });
  }

  /// Stop real-time live scores polling
  void stopPolling() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
    print('Stopped live scores polling');
  }

  /// Get the live scores stream
  Stream<List<LiveScore>> get scoresStream => _scoresController.stream;

  /// Check if polling is currently running
  bool get isRunning => _isRunning;

  /// Update the current week/season
  void updateWeek(int week, {int? season}) {
    _currentWeek = week;
    if (season != null) {
      _currentSeason = season;
    }
    print('Updated live scores service to week $week, season $_currentSeason');
  }

  /// Poll for live scores
  Future<void> _pollScores() async {
    if (_nflRepository == null) {
      print('LiveScoresService not initialized');
      return;
    }

    try {
      print('Polling live scores for week $_currentWeek...');

      // Get games for current week
      final games = await _nflRepository!.listGames(
        season: _currentSeason,
        week: _currentWeek,
      );

      // Convert to live scores
      final liveScores = games
          .map(
            (game) => LiveScore(
              gameId: game.id,
              homeTeam: game.homeTeam,
              awayTeam: game.awayTeam,
              homeScore: game.homeScore,
              awayScore: game.awayScore,
              status: _convertGameStatusToString(game.status),
              quarter: game.quarter,
              timeRemaining: game.timeRemaining,
              isLive: game.status == GameStatus.IN_PROGRESS,
              gameDate: game.date,
            ),
          )
          .toList();

      // Check if there are any live games
      final liveGames = liveScores.where((score) => score.isLive).length;
      if (liveGames > 0) {
        print('Found $liveGames live games, updating scores...');
      }

      // Emit the scores
      _scoresController.add(liveScores);
    } catch (e) {
      print('Error polling live scores: $e');
      // Don't emit error to stream, just log it
    }
  }

  /// Convert game status to string
  String _convertGameStatusToString(GameStatus status) {
    switch (status) {
      case GameStatus.SCHEDULED:
        return 'SCHEDULED';
      case GameStatus.IN_PROGRESS:
        return 'LIVE';
      case GameStatus.FINAL:
        return 'FINAL';
    }
  }

  /// Get current live scores (one-time fetch)
  Future<List<LiveScore>> getCurrentScores() async {
    if (_nflRepository == null) {
      return [];
    }

    try {
      final games = await _nflRepository!.listGames(
        season: _currentSeason,
        week: _currentWeek,
      );

      return games
          .map(
            (game) => LiveScore(
              gameId: game.id,
              homeTeam: game.homeTeam,
              awayTeam: game.awayTeam,
              homeScore: game.homeScore,
              awayScore: game.awayScore,
              status: _convertGameStatusToString(game.status),
              quarter: game.quarter,
              timeRemaining: game.timeRemaining,
              isLive: game.status == GameStatus.IN_PROGRESS,
              gameDate: game.date,
            ),
          )
          .toList();
    } catch (e) {
      print('Error getting current scores: $e');
      return [];
    }
  }

  /// Dispose resources
  void dispose() {
    stopPolling();
    _scoresController.close();
  }
}
