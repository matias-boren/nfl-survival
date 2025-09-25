import 'package:nfl_survival/data/models/nfl.dart';

abstract class ScoresRepository {
  Future<List<LiveScore>> getLiveScores();
  Future<List<LiveScore>> getScoresByWeek(int week);
  Future<LiveScore> getGameScore(String gameId);
}
