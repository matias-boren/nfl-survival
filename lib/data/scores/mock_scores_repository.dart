import 'package:nfl_survival/data/scores/scores_repositories.dart';
import 'package:nfl_survival/data/models/nfl.dart';

class MockScoresRepository implements ScoresRepository {
  @override
  Future<List<LiveScore>> getLiveScores() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    return [
      LiveScore(
        gameId: 'game1',
        homeTeam: Team(
          id: 'BUF',
          name: 'Buffalo Bills',
          abbreviation: 'BUF',
          city: 'Buffalo',
        ),
        awayTeam: Team(
          id: 'LAR',
          name: 'Los Angeles Rams',
          abbreviation: 'LAR',
          city: 'Los Angeles',
        ),
        homeScore: 24,
        awayScore: 17,
        status: 'In Progress',
        quarter: 4,
        timeRemaining: '2:34',
        isLive: true,
      ),
      LiveScore(
        gameId: 'game2',
        homeTeam: Team(
          id: 'ATL',
          name: 'Atlanta Falcons',
          abbreviation: 'ATL',
          city: 'Atlanta',
        ),
        awayTeam: Team(
          id: 'NO',
          name: 'New Orleans Saints',
          abbreviation: 'NO',
          city: 'New Orleans',
        ),
        homeScore: 14,
        awayScore: 10,
        status: 'In Progress',
        quarter: 2,
        timeRemaining: '8:45',
        isLive: true,
      ),
      LiveScore(
        gameId: 'game3',
        homeTeam: Team(
          id: 'CAR',
          name: 'Carolina Panthers',
          abbreviation: 'CAR',
          city: 'Carolina',
        ),
        awayTeam: Team(
          id: 'CLE',
          name: 'Cleveland Browns',
          abbreviation: 'CLE',
          city: 'Cleveland',
        ),
        homeScore: 7,
        awayScore: 0,
        status: 'In Progress',
        quarter: 1,
        timeRemaining: '12:30',
        isLive: true,
      ),
      LiveScore(
        gameId: 'game4',
        homeTeam: Team(
          id: 'CHI',
          name: 'Chicago Bears',
          abbreviation: 'CHI',
          city: 'Chicago',
        ),
        awayTeam: Team(
          id: 'SF',
          name: 'San Francisco 49ers',
          abbreviation: 'SF',
          city: 'San Francisco',
        ),
        homeScore: 0,
        awayScore: 0,
        status: 'Scheduled',
        quarter: 0,
        timeRemaining: '2:00 PM',
        isLive: false,
      ),
      LiveScore(
        gameId: 'game5',
        homeTeam: Team(
          id: 'CIN',
          name: 'Cincinnati Bengals',
          abbreviation: 'CIN',
          city: 'Cincinnati',
        ),
        awayTeam: Team(
          id: 'PIT',
          name: 'Pittsburgh Steelers',
          abbreviation: 'PIT',
          city: 'Pittsburgh',
        ),
        homeScore: 0,
        awayScore: 0,
        status: 'Scheduled',
        quarter: 0,
        timeRemaining: '4:25 PM',
        isLive: false,
      ),
    ];
  }

  @override
  Future<List<LiveScore>> getScoresByWeek(int week) async {
    // For now, return the same live scores
    return getLiveScores();
  }

  @override
  Future<LiveScore> getGameScore(String gameId) async {
    final scores = await getLiveScores();
    return scores.firstWhere((score) => score.gameId == gameId);
  }
}