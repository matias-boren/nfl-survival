import 'package:pick1/data/models/pick.dart';

abstract class PicksRepository {
  Future<Pick> submitPick({
    required String leagueId,
    required String userId,
    required int week,
    required String teamId,
  });
  Future<List<Pick>> listPicks(String leagueId, int week);
  Future<Pick?> getUserPick(String leagueId, String userId, int week);
  Future<void> updatePickResult({
    required String pickId,
    required PickResult result,
  });
  Future<List<Pick>> getUserPicksForLeague(String userId, String leagueId);
  Future<List<Pick>> getLeaguePicks(String leagueId);
  Future<bool> canUserSubmitPick({
    required String leagueId,
    required String userId,
    required int week,
  });
}
