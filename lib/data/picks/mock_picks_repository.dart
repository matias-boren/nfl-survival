import 'package:nfl_survival/data/models/pick.dart';
import 'package:nfl_survival/data/picks/picks_repositories.dart';

class MockPicksRepository implements PicksRepository {
  // In-memory storage for testing
  static final List<Pick> _picks = [];

  @override
  Future<Pick> submitPick({
    required String leagueId,
    required String userId,
    required int week,
    required String teamId,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate network delay

    // Remove any existing pick for this user/league/week (survival pool = one pick per week)
    _picks.removeWhere(
      (pick) =>
          pick.leagueId == leagueId &&
          pick.userId == userId &&
          pick.week == week,
    );

    final newPick = Pick(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      leagueId: leagueId,
      userId: userId,
      week: week,
      teamId: teamId,
      madeAtIso: DateTime.now().toUtc().toIso8601String(),
      locked: false,
      result: PickResult.PENDING,
    );

    _picks.add(newPick);
    return newPick;
  }

  @override
  Future<List<Pick>> listPicks(String leagueId, int week) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    ); // Simulate network delay

    return _picks
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

  @override
  Future<void> updatePickResult({
    required String pickId,
    required PickResult result,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final pickIndex = _picks.indexWhere((pick) => pick.id == pickId);
    if (pickIndex == -1) {
      throw Exception('Pick not found: $pickId');
    }

    final updatedPick = _picks[pickIndex].copyWith(result: result);
    _picks[pickIndex] = updatedPick;
  }

  @override
  Future<List<Pick>> getUserPicksForLeague(
    String userId,
    String leagueId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _picks
        .where((pick) => pick.userId == userId && pick.leagueId == leagueId)
        .toList();
  }

  @override
  Future<List<Pick>> getLeaguePicks(String leagueId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _picks.where((pick) => pick.leagueId == leagueId).toList();
  }
}
