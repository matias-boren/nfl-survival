import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nfl_survival/data/nfl/nfl_repositories.dart';
import 'package:nfl_survival/data/models/nfl.dart';
import 'package:nfl_survival/core/config/api_config.dart';

/// NFL Repository that uses server sync instead of calling ESPN directly
class ServerSyncNflRepository implements NflRepository {
  final http.Client _client;

  ServerSyncNflRepository({http.Client? client})
    : _client = client ?? http.Client();

  @override
  Future<List<Game>> listGames({required int season, required int week}) async {
    try {
      // Call our server instead of ESPN directly
      final url = ApiConfig.getLiveScoresUrl(week, season);
      print('Fetching NFL data from server: $url');

      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'NFL-Survival-App/1.0',
        },
      );

      print('Server Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Server Response Data: ${data.keys}');

        // Parse the server response
        final games = _parseServerGamesResponse(data, season, week);
        print('Converted ${games.length} games from server for Week $week');

        return games;
      } else {
        print(
          'Server failed with status ${response.statusCode}, using mock data',
        );
        return _getMockGames(season, week);
      }
    } catch (e) {
      print('Server error: $e, using mock data');
      return _getMockGames(season, week);
    }
  }

  @override
  Future<List<Team>> listTeams() async {
    try {
      // For teams, we can still use ESPN directly as it doesn't change often
      final url =
          'https://site.api.espn.com/apis/site/v2/sports/football/nfl/teams';
      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'NFL-Survival-App/1.0',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return _convertEspnDataToTeams(data);
      } else {
        return _getMockTeams();
      }
    } catch (e) {
      return _getMockTeams();
    }
  }

  @override
  Future<List<LiveScore>> getLiveScores() async {
    try {
      final currentDate = DateTime.now();
      final season = currentDate.year;
      final week = _getCurrentWeek(currentDate);

      // Call our server for live scores
      final url = ApiConfig.getLiveScoresUrl(week, season);
      print('Fetching live scores from server: $url');

      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'NFL-Survival-App/1.0',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return _parseServerLiveScoresResponse(data);
      } else {
        print('Server live scores failed: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching live scores: $e');
      return [];
    }
  }

  @override
  Future<DateTime?> getPickDeadline(int week) async {
    // This could be calculated server-side or use a simple calculation
    final now = DateTime.now();
    final currentWeek = _getCurrentWeek(now);

    if (week <= currentWeek) {
      return null; // Week has already started
    }

    // Return Thursday 8:20 PM ET for the week
    final thursday = _getNextThursday(now);
    return thursday.subtract(const Duration(hours: 4)); // Convert to ET
  }

  @override
  void dispose() {
    _client.close();
  }

  /// Parse server games response
  List<Game> _parseServerGamesResponse(
    Map<String, dynamic> data,
    int season,
    int week,
  ) {
    try {
      final List<dynamic> gamesData = data['games'] ?? [];
      final List<Game> games = [];

      for (final gameData in gamesData) {
        final homeTeam = gameData['homeTeam'];
        final awayTeam = gameData['awayTeam'];

        final game = Game(
          id:
              gameData['id']?.toString() ??
              DateTime.now().millisecondsSinceEpoch.toString(),
          homeTeam: Team(
            id: homeTeam['id']?.toString() ?? '',
            name: homeTeam['name'] ?? 'Unknown',
            abbreviation: homeTeam['abbreviation'] ?? 'UNK',
            city: homeTeam['city'] ?? 'Unknown',
            logoUrl: homeTeam['logoUrl'],
            color: homeTeam['color'],
            alternateColor: homeTeam['alternateColor'],
          ),
          awayTeam: Team(
            id: awayTeam['id']?.toString() ?? '',
            name: awayTeam['name'] ?? 'Unknown',
            abbreviation: awayTeam['abbreviation'] ?? 'UNK',
            city: awayTeam['city'] ?? 'Unknown',
            logoUrl: awayTeam['logoUrl'],
            color: awayTeam['color'],
            alternateColor: awayTeam['alternateColor'],
          ),
          homeScore: gameData['homeScore'] ?? 0,
          awayScore: gameData['awayScore'] ?? 0,
          status: _convertStringToGameStatus(gameData['status'] ?? 'SCHEDULED'),
          quarter: gameData['quarter'] ?? 0,
          timeRemaining: gameData['timeRemaining'] ?? '',
          date: DateTime.tryParse(gameData['date'] ?? '') ?? DateTime.now(),
          week: week,
          season: season,
        );

        games.add(game);
      }

      return games;
    } catch (e) {
      print('Error parsing server games response: $e');
      return _getMockGames(season, week);
    }
  }

  /// Parse server live scores response
  List<LiveScore> _parseServerLiveScoresResponse(Map<String, dynamic> data) {
    try {
      final List<dynamic> scoresData = data['scores'] ?? [];
      return scoresData.map((scoreData) {
        return LiveScore(
          gameId: scoreData['gameId'] ?? '',
          homeTeam: Team(
            id: scoreData['homeTeam']['id']?.toString() ?? '',
            name: scoreData['homeTeam']['name'] ?? '',
            abbreviation: scoreData['homeTeam']['abbreviation'] ?? '',
            city: scoreData['homeTeam']['city'] ?? '',
            logoUrl: scoreData['homeTeam']['logoUrl'],
            color: scoreData['homeTeam']['color'],
            alternateColor: scoreData['homeTeam']['alternateColor'],
          ),
          awayTeam: Team(
            id: scoreData['awayTeam']['id']?.toString() ?? '',
            name: scoreData['awayTeam']['name'] ?? '',
            abbreviation: scoreData['awayTeam']['abbreviation'] ?? '',
            city: scoreData['awayTeam']['city'] ?? '',
            logoUrl: scoreData['awayTeam']['logoUrl'],
            color: scoreData['awayTeam']['color'],
            alternateColor: scoreData['awayTeam']['alternateColor'],
          ),
          homeScore: scoreData['homeScore'] ?? 0,
          awayScore: scoreData['awayScore'] ?? 0,
          status: scoreData['status'] ?? 'SCHEDULED',
          quarter: scoreData['quarter'] ?? 0,
          timeRemaining: scoreData['timeRemaining'] ?? '',
          isLive: scoreData['isLive'] ?? false,
          gameDate:
              DateTime.tryParse(scoreData['gameDate'] ?? '') ?? DateTime.now(),
        );
      }).toList();
    } catch (e) {
      print('Error parsing server live scores response: $e');
      return [];
    }
  }

  /// Convert string status to GameStatus enum
  GameStatus _convertStringToGameStatus(String status) {
    switch (status.toUpperCase()) {
      case 'SCHEDULED':
        return GameStatus.SCHEDULED;
      case 'IN_PROGRESS':
        return GameStatus.IN_PROGRESS;
      case 'FINAL':
        return GameStatus.FINAL;
      default:
        return GameStatus.SCHEDULED;
    }
  }

  /// Convert ESPN teams data to Team objects
  List<Team> _convertEspnDataToTeams(Map<String, dynamic> data) {
    try {
      final teams =
          data['sports']?[0]?['leagues']?[0]?['teams'] as List<dynamic>? ?? [];
      return teams.map((teamData) {
        final team = teamData['team'];
        return Team(
          id: team['id']?.toString() ?? '',
          name: team['displayName'] ?? 'Unknown',
          abbreviation: team['abbreviation'] ?? 'UNK',
          city: team['location'] ?? 'Unknown',
          logoUrl: team['logo']?['href'],
          color: team['color'],
          alternateColor: team['alternateColor'],
        );
      }).toList();
    } catch (e) {
      return _getMockTeams();
    }
  }

  /// Get current week
  int _getCurrentWeek(DateTime date) {
    final now = date;
    final seasonStart = DateTime(now.year, 9, 1);
    final daysSinceStart = now.difference(seasonStart).inDays;
    final week = (daysSinceStart / 7).floor() + 1;
    return week.clamp(1, 18);
  }

  /// Get next Thursday
  DateTime _getNextThursday(DateTime now) {
    final daysUntilThursday = (4 - now.weekday) % 7;
    if (daysUntilThursday == 0) {
      return now.add(const Duration(days: 7));
    }
    return now.add(Duration(days: daysUntilThursday));
  }

  /// Mock games fallback
  List<Game> _getMockGames(int season, int week) {
    return [
      Game(
        id: '1',
        homeTeam: Team(
          id: '1',
          name: 'Chiefs',
          abbreviation: 'KC',
          city: 'Kansas City',
          logoUrl: null,
          color: '#E31837',
          alternateColor: '#FFB81C',
        ),
        awayTeam: Team(
          id: '2',
          name: 'Bills',
          abbreviation: 'BUF',
          city: 'Buffalo',
          logoUrl: null,
          color: '#00338D',
          alternateColor: '#C60C30',
        ),
        homeScore: 0,
        awayScore: 0,
        status: GameStatus.SCHEDULED,
        quarter: 0,
        timeRemaining: '',
        date: DateTime.now().add(const Duration(days: 1)),
        week: week,
        season: season,
      ),
    ];
  }

  /// Mock teams fallback
  List<Team> _getMockTeams() {
    return [
      Team(
        id: '1',
        name: 'Chiefs',
        abbreviation: 'KC',
        city: 'Kansas City',
        logoUrl: null,
        color: '#E31837',
        alternateColor: '#FFB81C',
      ),
      Team(
        id: '2',
        name: 'Bills',
        abbreviation: 'BUF',
        city: 'Buffalo',
        logoUrl: null,
        color: '#00338D',
        alternateColor: '#C60C30',
      ),
    ];
  }
}
