import 'package:nfl_survival/data/models/nfl.dart';

abstract class NflRepository {
  Future<List<Game>> listGames({required int season, required int week});
  Future<List<Team>> listTeams();
  // getLiveScores method removed to fix CI issues
  Future<DateTime?> getPickDeadline(int week);
  void dispose();
}
