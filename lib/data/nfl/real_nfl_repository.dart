import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nfl_survival/data/nfl/api_models.dart';
import 'package:nfl_survival/data/nfl/nfl_repositories.dart';
import 'package:nfl_survival/data/models/nfl.dart';

class RealNflRepository implements NflRepository {
  static const String _baseUrl =
      'https://site.api.espn.com/apis/site/v2/sports/football/nfl';

  final http.Client _client;

  RealNflRepository({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<List<Game>> listGames({required int season, required int week}) async {
    try {
      final url = '$_baseUrl/scoreboard?dates=$season&week=$week';
      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'NFL-Survival-App/1.0',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final espnResponse = EspnNflResponse.fromJson(data);
        return _convertEspnGamesToGames(espnResponse.events);
      } else {
        throw Exception('Failed to load games: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching games: $e');
    }
  }

  @override
  Future<List<Team>> listTeams() async {
    try {
      final url = '$_baseUrl/teams';
      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'NFL-Survival-App/1.0',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final espnResponse = EspnTeamsResponse.fromJson(data);
        return _convertEspnTeamsToTeams(espnResponse.teams);
      } else {
        throw Exception('Failed to load teams: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching teams: $e');
    }
  }

  @override
  Future<List<LiveScore>> getLiveScores() async {
    try {
      // Get current week's games for live scores
      final currentDate = DateTime.now();
      final season = currentDate.year;
      final week = _getCurrentWeek(currentDate);

      final games = await listGames(season: season, week: week);

      return games
          .map(
            (game) => LiveScore(
              gameId: game.id,
              homeTeam: game.homeTeam,
              awayTeam: game.awayTeam,
              homeScore: game.homeScore,
              awayScore: game.awayScore,
              status: _convertGameStatus(game.status),
              quarter: game.quarter,
              timeRemaining: game.timeRemaining,
              isLive: game.status == GameStatus.IN_PROGRESS,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Error fetching live scores: $e');
    }
  }

  List<Game> _convertEspnGamesToGames(List<EspnGame> espnGames) {
    return espnGames.map((espnGame) {
      final competition = espnGame.competitions.isNotEmpty
          ? espnGame.competitions.first
          : throw Exception('No competition found');

      final competitors = competition.competitors;
      if (competitors.length < 2) {
        throw Exception('Invalid game: not enough competitors');
      }

      final homeCompetitor = competitors.firstWhere(
        (c) => c.homeAway == 'home',
        orElse: () => competitors.first,
      );
      final awayCompetitor = competitors.firstWhere(
        (c) => c.homeAway == 'away',
        orElse: () => competitors.last,
      );

      return Game(
        id: espnGame.id,
        homeTeam: _convertEspnTeamToTeam(homeCompetitor.team),
        awayTeam: _convertEspnTeamToTeam(awayCompetitor.team),
        homeScore: int.tryParse(homeCompetitor.score?.value ?? '0') ?? 0,
        awayScore: int.tryParse(awayCompetitor.score?.value ?? '0') ?? 0,
        status: _convertEspnStatusToGameStatus(competition.status),
        quarter: _extractQuarter(competition.status),
        timeRemaining: competition.status.displayClock,
        date: DateTime.parse(espnGame.date.date),
        week: espnGame.week.number,
        season: espnGame.season.year,
      );
    }).toList();
  }

  List<Team> _convertEspnTeamsToTeams(List<EspnTeam> espnTeams) {
    return espnTeams
        .map((espnTeam) => _convertEspnTeamToTeam(espnTeam))
        .toList();
  }

  Team _convertEspnTeamToTeam(EspnTeam espnTeam) {
    return Team(
      id: espnTeam.id,
      name: espnTeam.displayName,
      abbreviation: espnTeam.abbreviation,
      city: espnTeam.location,
      logoUrl: espnTeam.logo.href,
      color: espnTeam.color,
      alternateColor: espnTeam.alternateColor,
    );
  }

  GameStatus _convertEspnStatusToGameStatus(EspnStatus status) {
    if (status.completed) {
      return GameStatus.FINAL;
    } else if (status.type.id == '1') {
      // Scheduled
      return GameStatus.SCHEDULED;
    } else if (status.type.id == '2') {
      // In Progress
      return GameStatus.IN_PROGRESS;
    } else if (status.type.id == '3') {
      // Final
      return GameStatus.FINAL;
    } else {
      return GameStatus.SCHEDULED;
    }
  }

  int _extractQuarter(EspnStatus status) {
    return status.period;
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

  @override
  Future<DateTime?> getPickDeadline(int week) async {
    // For now, return null - this would need to be implemented based on
    // actual NFL schedule data or business rules
    return null;
  }

  @override
  void dispose() {
    _client.close();
  }
}
