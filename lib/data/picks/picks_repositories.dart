import 'package:nfl_survival/data/models/pick.dart';

abstract class PicksRepository {
  Future<Pick> submitPick({
    required String leagueId,
    required String userId,
    required int week,
    required String teamId,
  });
  Future<List<Pick>> listPicks(String leagueId, int week);
  Future<Pick?> getUserPick(String leagueId, String userId, int week);
}
