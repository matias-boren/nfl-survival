import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/pick.dart';

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

class MockPicksRepository implements PicksRepository {
  static const String _boxName = 'picks';
  Future<Box> _box() async => Hive.openBox(_boxName);

  @override
  Future<Pick?> getUserPick(String leagueId, String userId, int week) async {
    final picks = await listPicks(leagueId, week);
    try {
      return picks.firstWhere((p) => p.userId == userId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Pick>> listPicks(String leagueId, int week) async {
    final box = await _box();
    final key = '${leagueId}_$week';
    final List data = box.get(key) as List? ?? [];
    return data
        .whereType<Map>()
        .map((e) => Pick.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<Pick> submitPick({
    required String leagueId,
    required String userId,
    required int week,
    required String teamId,
  }) async {
    final box = await _box();
    final key = '${leagueId}_$week';
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final newPick = Pick(
      id: '$userId-$leagueId-$week',
      leagueId: leagueId,
      userId: userId,
      week: week,
      teamId: teamId,
      madeAtIso: nowIso,
      locked: false,
      result: PickResult.PENDING,
    );
    final List data = box.get(key) as List? ?? [];
    data.removeWhere((e) => (e as Map)['userId'] == userId);
    data.add(newPick.toJson());
    await box.put(key, data);
    return newPick;
  }
}

