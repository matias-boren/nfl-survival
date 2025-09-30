import 'package:pick1/data/nfl/nfl_repositories.dart';
import 'package:pick1/data/models/nfl.dart';

class RealNflRepository implements NflRepository {
  @override
  Future<List<Game>> listGames({required int season, required int week}) async {
    // Return mock data since live scores are disabled
    return _getMockGames(season, week);
  }

  @override
  Future<List<Team>> listTeams() async {
    // Return mock data since live scores are disabled
    return _getMockTeams();
  }

  List<Game> _getMockGames(int season, int week) {
    return [
      Game(
        id: 'mock-game-1',
        homeTeam: Team(
          id: 'DAL',
          name: 'Dallas Cowboys',
          abbreviation: 'DAL',
          city: 'Dallas',
          logoUrl: 'https://a.espncdn.com/i/teamlogos/nfl/500/dal.png',
          color: '#002244',
          alternateColor: '#B0B7BC',
        ),
        awayTeam: Team(
          id: 'NYG',
          name: 'New York Giants',
          abbreviation: 'NYG',
          city: 'New York',
          logoUrl: 'https://a.espncdn.com/i/teamlogos/nfl/500/nyg.png',
          color: '#0B2265',
          alternateColor: '#A71930',
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
        id: 'mock-game-2',
        homeTeam: Team(
          id: 'PHI',
          name: 'Philadelphia Eagles',
          abbreviation: 'PHI',
          city: 'Philadelphia',
          logoUrl: 'https://a.espncdn.com/i/teamlogos/nfl/500/phi.png',
          color: '#004C54',
          alternateColor: '#A5ACAF',
        ),
        awayTeam: Team(
          id: 'WAS',
          name: 'Washington Commanders',
          abbreviation: 'WAS',
          city: 'Washington',
          logoUrl: 'https://a.espncdn.com/i/teamlogos/nfl/500/was.png',
          color: '#5A1414',
          alternateColor: '#FFB612',
        ),
        homeScore: 0,
        awayScore: 0,
        status: GameStatus.SCHEDULED,
        quarter: 0,
        timeRemaining: '',
        date: DateTime.now().add(const Duration(days: 2)),
        week: week,
        season: season,
      ),
    ];
  }

  List<Team> _getMockTeams() {
    return [
      Team(
        id: 'DAL',
        name: 'Dallas Cowboys',
        abbreviation: 'DAL',
        city: 'Dallas',
        logoUrl: 'https://a.espncdn.com/i/teamlogos/nfl/500/dal.png',
        color: '#002244',
        alternateColor: '#B0B7BC',
      ),
      Team(
        id: 'NYG',
        name: 'New York Giants',
        abbreviation: 'NYG',
        city: 'New York',
        logoUrl: 'https://a.espncdn.com/i/teamlogos/nfl/500/nyg.png',
        color: '#0B2265',
        alternateColor: '#A71930',
      ),
      Team(
        id: 'PHI',
        name: 'Philadelphia Eagles',
        abbreviation: 'PHI',
        city: 'Philadelphia',
        logoUrl: 'https://a.espncdn.com/i/teamlogos/nfl/500/phi.png',
        color: '#004C54',
        alternateColor: '#A5ACAF',
      ),
      Team(
        id: 'WAS',
        name: 'Washington Commanders',
        abbreviation: 'WAS',
        city: 'Washington',
        logoUrl: 'https://a.espncdn.com/i/teamlogos/nfl/500/was.png',
        color: '#5A1414',
        alternateColor: '#FFB612',
      ),
    ];
  }

  @override
  Future<DateTime?> getPickDeadline(int week) async {
    // For now, return null - this would need to be implemented based on
    // actual NFL schedule data or business rules
    return null;
  }

  @override
  void dispose() {
    // No resources to dispose since we're using mock data
  }
}
