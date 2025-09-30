import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nfl_survival/data/nfl/nfl_repositories.dart';
import 'package:nfl_survival/data/models/nfl.dart';

class HybridNflRepository implements NflRepository {
  static const String _baseUrl =
      'https://site.api.espn.com/apis/site/v2/sports/football/nfl';

  final http.Client _client;

  HybridNflRepository({http.Client? client})
    : _client = client ?? http.Client();

  @override
  Future<List<Game>> listGames({required int season, required int week}) async {
    try {
      // Use current date for real NFL data
      final currentDate = DateTime.now();
      final url = '$_baseUrl/scoreboard';
      print('Fetching NFL data from: $url');

      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json, text/plain, */*',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
          'Accept-Language': 'en-US,en;q=0.9',
          'Accept-Encoding': 'gzip, deflate, br',
          'Referer': 'https://www.espn.com/',
          'Origin': 'https://www.espn.com',
        },
      );

      print('ESPN API Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('ESPN API Response Data: ${data.keys}');

        // Get the actual week from ESPN API
        final actualWeek = data['week']?['number'] ?? week;
        final actualSeason = data['season']?['year'] ?? season;
        print('ESPN API - Actual Week: $actualWeek, Season: $actualSeason');

        final games = _convertEspnDataToGames(data, actualSeason, actualWeek);
        print(
          'Converted ${games.length} games from ESPN API for Week $actualWeek',
        );

        // Store the first game time for deadline calculation
        if (games.isNotEmpty) {
          final firstGame = games.reduce(
            (a, b) => a.date.isBefore(b.date) ? a : b,
          );
          print('First game time: ${firstGame.date}');
        }

        return games;
      } else {
        print(
          'ESPN API failed with status ${response.statusCode}, using mock data',
        );
        return _getMockGames(season, week);
      }
    } catch (e) {
      print('ESPN API error: $e, using mock data');
      return _getMockGames(season, week);
    }
  }

  @override
  Future<List<Team>> listTeams() async {
    try {
      final url = '$_baseUrl/teams';
      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json, text/plain, */*',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
          'Accept-Language': 'en-US,en;q=0.9',
          'Accept-Encoding': 'gzip, deflate, br',
          'Referer': 'https://www.espn.com/',
          'Origin': 'https://www.espn.com',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return _convertEspnDataToTeams(data);
      } else {
        // Fallback to mock data if API fails
        return _getMockTeams();
      }
    } catch (e) {
      // Fallback to mock data if API fails
      return _getMockTeams();
    }
  }

  // getLiveScores method removed to fix CI issues

  List<Game> _convertEspnDataToGames(
    Map<String, dynamic> data,
    int season,
    int week,
  ) {
    try {
      print('Converting ESPN data: ${data.keys}');
      final events = data['events'] as List<dynamic>? ?? [];
      print('Found ${events.length} events in ESPN response');
      final games = <Game>[];

      for (final event in events) {
        print('Processing event: ${event['name']}');
        final competitions = event['competitions'] as List<dynamic>? ?? [];
        if (competitions.isEmpty) {
          print('No competitions found for event');
          continue;
        }

        final competition = competitions.first;
        final competitors = competition['competitors'] as List<dynamic>? ?? [];
        if (competitors.length < 2) {
          print('Not enough competitors found');
          continue;
        }

        final homeCompetitor = competitors.firstWhere(
          (c) => c['homeAway'] == 'home',
          orElse: () => competitors.first,
        );
        final awayCompetitor = competitors.firstWhere(
          (c) => c['homeAway'] == 'away',
          orElse: () => competitors.last,
        );

        final homeTeam = homeCompetitor['team'];
        final awayTeam = awayCompetitor['team'];

        print('Game: ${awayTeam['displayName']} @ ${homeTeam['displayName']}');
        print('Game date: ${event['date']}');
        print('Home team logo: ${homeTeam['logo']}');
        print('Away team logo: ${awayTeam['logo']}');
        print('Home score: ${homeCompetitor['score']}');
        print('Away score: ${awayCompetitor['score']}');
        print('Home score type: ${homeCompetitor['score'].runtimeType}');
        print('Away score type: ${awayCompetitor['score'].runtimeType}');
        print('Competition status: ${competition['status']}');

        final game = Game(
          id:
              event['id']?.toString() ??
              DateTime.now().millisecondsSinceEpoch.toString(),
          homeTeam: Team(
            id: homeTeam['id']?.toString() ?? '',
            name: homeTeam['displayName'] ?? 'Unknown',
            abbreviation: homeTeam['abbreviation'] ?? 'UNK',
            city: homeTeam['location'] ?? 'Unknown',
            logoUrl: homeTeam['logo'] is Map
                ? homeTeam['logo']['href']?.toString()
                : null,
            color: homeTeam['color'],
            alternateColor: homeTeam['alternateColor'],
          ),
          awayTeam: Team(
            id: awayTeam['id']?.toString() ?? '',
            name: awayTeam['displayName'] ?? 'Unknown',
            abbreviation: awayTeam['abbreviation'] ?? 'UNK',
            city: awayTeam['location'] ?? 'Unknown',
            logoUrl: awayTeam['logo'] is Map
                ? awayTeam['logo']['href']?.toString()
                : null,
            color: awayTeam['color'],
            alternateColor: awayTeam['alternateColor'],
          ),
          homeScore: _parseScore(homeCompetitor['score']),
          awayScore: _parseScore(awayCompetitor['score']),
          status: () {
            print('About to convert status for ${awayTeam['displayName']} @ ${homeTeam['displayName']}');
            return _convertEspnStatusToGameStatus(competition['status']);
          }(),
          quarter: competition['status']?['period'] ?? 0,
          timeRemaining: competition['status']?['displayClock'] ?? '',
          date: DateTime.tryParse(event['date'] ?? '') ?? DateTime.now(),
          week: week,
          season: season,
        );

        games.add(game);
      }

      print('Successfully converted ${games.length} games from ESPN API');
      return games;
    } catch (e) {
      print('Error converting ESPN data: $e');
      return _getMockGames(season, week);
    }
  }

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

  int _parseScore(dynamic score) {
    if (score == null) return 0;
    if (score is int) return score;
    if (score is String) return int.tryParse(score) ?? 0;
    if (score is Map && score['value'] != null) {
      return int.tryParse(score['value'].toString()) ?? 0;
    }
    return 0;
  }

  GameStatus _convertEspnStatusToGameStatus(Map<String, dynamic>? status) {
    if (status == null) return GameStatus.SCHEDULED;

    // ESPN API has completed field nested inside type object
    final completed = status['type']?['completed'] as bool? ?? false;
    final type = status['type']?['id'] as String?;
    final typeName = status['type']?['name'] as String?;

    print('ESPN Game Status Debug:');
    print('  completed: $completed');
    print('  type.id: $type');
    print('  type.name: $typeName');
    print('  full status: $status');

    if (completed) {
      print('  -> Returning FINAL');
      return GameStatus.FINAL;
    } else if (type == '2') {
      // In Progress
      print('  -> Returning IN_PROGRESS');
      return GameStatus.IN_PROGRESS;
    } else {
      print('  -> Returning SCHEDULED');
      return GameStatus.SCHEDULED;
    }
  }

  String _convertGameStatus(GameStatus status) {
    switch (status) {
      case GameStatus.SCHEDULED:
        return 'Scheduled';
      case GameStatus.IN_PROGRESS:
        return 'In Progress';
      case GameStatus.FINAL:
        return 'Final';
    }
  }

  int _getCurrentWeek(DateTime date) {
    // Simple week calculation - in production, you'd want more sophisticated logic
    final seasonStart = DateTime(date.year, 9, 1); // Approximate season start
    final daysSinceStart = date.difference(seasonStart).inDays;
    return (daysSinceStart / 7).floor().clamp(1, 18);
  }

  // Mock data fallbacks
  List<Game> _getMockGames(int season, int week) {
    return [
      Game(
        id: '1',
        homeTeam: Team(
          id: 'KC',
          name: 'Kansas City Chiefs',
          abbreviation: 'KC',
          city: 'Kansas City',
        ),
        awayTeam: Team(
          id: 'BUF',
          name: 'Buffalo Bills',
          abbreviation: 'BUF',
          city: 'Buffalo',
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
      Game(
        id: '2',
        homeTeam: Team(
          id: 'DAL',
          name: 'Dallas Cowboys',
          abbreviation: 'DAL',
          city: 'Dallas',
        ),
        awayTeam: Team(
          id: 'PHI',
          name: 'Philadelphia Eagles',
          abbreviation: 'PHI',
          city: 'Philadelphia',
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

  List<Team> _getMockTeams() {
    return [
      Team(
        id: 'KC',
        name: 'Kansas City Chiefs',
        abbreviation: 'KC',
        city: 'Kansas City',
      ),
      Team(
        id: 'BUF',
        name: 'Buffalo Bills',
        abbreviation: 'BUF',
        city: 'Buffalo',
      ),
      Team(
        id: 'DAL',
        name: 'Dallas Cowboys',
        abbreviation: 'DAL',
        city: 'Dallas',
      ),
      Team(
        id: 'PHI',
        name: 'Philadelphia Eagles',
        abbreviation: 'PHI',
        city: 'Philadelphia',
      ),
    ];
  }

  // Get the deadline for a specific week (first game kickoff time)
  Future<DateTime?> getPickDeadline(int week) async {
    try {
      final games = await listGames(season: 2025, week: week);
      if (games.isEmpty) {
        print('No games found for week $week');
        return null;
      }

      // Find the first game (earliest kickoff time)
      final firstGame = games.reduce((a, b) => a.date.isBefore(b.date) ? a : b);
      print(
        'First game for week $week: ${firstGame.awayTeam.abbreviation} @ ${firstGame.homeTeam.abbreviation} at ${firstGame.date}',
      );

      return firstGame.date;
    } catch (e) {
      print('Error getting deadline for week $week: $e');
      return null;
    }
  }

  @override
  void dispose() {
    _client.close();
  }
}
