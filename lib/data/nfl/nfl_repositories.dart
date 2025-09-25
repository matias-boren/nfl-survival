import 'package:nfl_survival/data/models/nfl.dart';

abstract class NflRepository {
  Future<List<Game>> listGames({required int season, required int week});
  Future<List<Team>> listTeams();
  Future<List<LiveScore>> getLiveScores();
  Future<DateTime?> getPickDeadline(int week);
  void dispose();
}
