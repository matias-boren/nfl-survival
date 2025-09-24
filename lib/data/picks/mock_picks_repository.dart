import 'package:hive_flutter/hive_flutter.dart';
import 'package:nfl_survival/data/models/pick.dart';
import 'package:nfl_survival/data/picks/picks_repositories.dart';

class MockPicksRepository implements PicksRepository {
  static const _picksBoxName = 'picksBox';

  Future<Box<String>> _openPicksBox() => Hive.openBox<String>(_picksBoxName);

  @override
  Future<Pick> submitPick({
    required String leagueId,
    required String userId,
    required int week,
    required String teamId,
  }) async {
    final newPick = Pick(
      id: 'pick_${DateTime.now().millisecondsSinceEpoch}',
      leagueId: leagueId,
      userId: userId,
      week: week,
      teamId: teamId,
      madeAtIso: DateTime.now().toUtc().toIso8601String(),
      locked: false,
      result: PickResult.PENDING,
    );
    final box = await _openPicksBox();
    await box.put(newPick.id, newPick.toJson().toString());
    return newPick;
  }

  @override
  Future<List<Pick>> listPicks(String leagueId, int week) async {
    final box = await _openPicksBox();
    return box.values
        .map((jsonString) => Pick.fromJson(Map<String, dynamic>.from(jsonString as Map)))
        .where((pick) => pick.leagueId == leagueId && pick.week == week)
        .toList();
  }

  @override
  Future<Pick?> getUserPick(String leagueId, String userId, int week) async {
    final picks = await listPicks(leagueId, week);
    try {
      return picks.firstWhere((pick) => pick.userId == userId);
    } catch (e) {
      return null;
    }
  }
}
