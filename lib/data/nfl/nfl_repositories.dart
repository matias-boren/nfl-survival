import 'package:nfl_survival/data/models/nfl.dart';

abstract class NflDataRepository {
  Future<List<int>> listWeeks(int season);
  Future<List<Game>> listGames(int season, int week);
  Future<List<Team>> listTeams(int season);
  Future<Game> getGame(String gameId);
}
