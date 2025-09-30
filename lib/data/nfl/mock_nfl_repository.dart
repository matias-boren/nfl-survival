import 'package:pick1/data/models/nfl.dart';
import 'package:pick1/data/nfl/nfl_repositories.dart';

class MockNflDataRepository implements NflRepository {
  @override
  Future<List<Game>> listGames({required int season, required int week}) async {
    print(
      'MockNflDataRepository.listGames called with season=$season, week=$week',
    );
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate network delay

    // Mock games data
    final games = [
      Game(
        id: 'game_1',
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
        id: 'game_2',
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
      Game(
        id: 'game_3',
        homeTeam: Team(
          id: 'SF',
          name: 'San Francisco 49ers',
          abbreviation: 'SF',
          city: 'San Francisco',
        ),
        awayTeam: Team(
          id: 'LAR',
          name: 'Los Angeles Rams',
          abbreviation: 'LAR',
          city: 'Los Angeles',
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
        id: 'game_4',
        homeTeam: Team(
          id: 'GB',
          name: 'Green Bay Packers',
          abbreviation: 'GB',
          city: 'Green Bay',
        ),
        awayTeam: Team(
          id: 'CHI',
          name: 'Chicago Bears',
          abbreviation: 'CHI',
          city: 'Chicago',
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
    print('MockNflDataRepository.listGames returning ${games.length} games');
    return games;
  }

  @override
  Future<List<Team>> listTeams() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    ); // Simulate network delay

    // Mock teams data
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
      Team(
        id: 'SF',
        name: 'San Francisco 49ers',
        abbreviation: 'SF',
        city: 'San Francisco',
      ),
      Team(
        id: 'LAR',
        name: 'Los Angeles Rams',
        abbreviation: 'LAR',
        city: 'Los Angeles',
      ),
      Team(
        id: 'GB',
        name: 'Green Bay Packers',
        abbreviation: 'GB',
        city: 'Green Bay',
      ),
      Team(
        id: 'CHI',
        name: 'Chicago Bears',
        abbreviation: 'CHI',
        city: 'Chicago',
      ),
    ];
  }

  // getLiveScores method removed to fix CI issues

  @override
  Future<DateTime?> getPickDeadline(int week) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // For testing, return a deadline 7 days from now
    return DateTime.now().add(const Duration(days: 7));
  }

  @override
  void dispose() {
    // No resources to dispose
  }
}
