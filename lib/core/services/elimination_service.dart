import 'package:pick1/data/models/league.dart';
import 'package:pick1/data/models/pick.dart';
import 'package:pick1/data/picks/picks_repositories.dart';
import 'package:pick1/data/leagues/league_repositories.dart';
import 'package:pick1/core/services/deadline_service.dart';

class EliminationService {
  final PicksRepository _picksRepository;
  final LeagueRepository _leagueRepository;
  final DeadlineService _deadlineService;

  EliminationService({
    required PicksRepository picksRepository,
    required LeagueRepository leagueRepository,
    required DeadlineService deadlineService,
  }) : _picksRepository = picksRepository,
       _leagueRepository = leagueRepository,
       _deadlineService = deadlineService;

  /// Check if a user is eliminated from a league
  Future<bool> isUserEliminated({
    required String userId,
    required String leagueId,
  }) async {
    try {
      // Get the league to check elimination status
      final league = await _leagueRepository.getLeague(leagueId);
      
      // Check if user is marked as eliminated in the league
      if (league.eliminatedUsers.containsKey(userId)) {
        return league.eliminatedUsers[userId] ?? false;
      }

      // If not explicitly marked, calculate based on picks
      return await _calculateEliminationStatus(
        userId: userId,
        leagueId: leagueId,
        league: league,
      );
    } catch (e) {
      print('Error checking elimination status: $e');
      return false; // Default to not eliminated if there's an error
    }
  }

  /// Calculate if a user should be eliminated based on their picks
  Future<bool> _calculateEliminationStatus({
    required String userId,
    required String leagueId,
    required League league,
  }) async {
    // Get all user picks for this league
    final userPicks = await _picksRepository.getUserPicksForLeague(
      userId,
      leagueId,
    );

    // Count losses
    final losses = userPicks
        .where((pick) => pick.result == PickResult.LOSE)
        .length;

    // Check if user exceeds max losses
    if (losses > league.settings.maxLosses) {
      return true;
    }

    // Check auto-eliminate on no pick rule
    if (league.settings.autoEliminateOnNoPick) {
      // Get current week from the deadline service (which uses ESPN API)
      final currentWeek = _deadlineService.getCurrentWeek();
      
      // Check if user has a pick for current week
      final currentWeekPick = userPicks
          .where((pick) => pick.week == currentWeek)
          .isNotEmpty;

      if (!currentWeekPick) {
        return true;
      }
    }

    return false;
  }

  /// Mark a user as eliminated in a league
  Future<void> eliminateUser({
    required String userId,
    required String leagueId,
  }) async {
    try {
      final league = await _leagueRepository.getLeague(leagueId);
      
      // Update the eliminated users map
      final updatedEliminatedUsers = Map<String, bool>.from(league.eliminatedUsers);
      updatedEliminatedUsers[userId] = true;
      
      // Update the league
      final updatedLeague = league.copyWith(
        eliminatedUsers: updatedEliminatedUsers,
      );
      
      await _leagueRepository.updateLeague(updatedLeague);
    } catch (e) {
      print('Error eliminating user: $e');
      rethrow;
    }
  }

  /// Get all eliminated users for a league
  Future<List<String>> getEliminatedUsers(String leagueId) async {
    try {
      final league = await _leagueRepository.getLeague(leagueId);
      
      return league.eliminatedUsers.entries
          .where((entry) => entry.value == true)
          .map((entry) => entry.key)
          .toList();
    } catch (e) {
      print('Error getting eliminated users: $e');
      return [];
    }
  }

  /// Get all active (non-eliminated) users for a league
  Future<List<String>> getActiveUsers(String leagueId) async {
    try {
      final league = await _leagueRepository.getLeague(leagueId);
      
      return league.memberIds
          .where((userId) => !(league.eliminatedUsers[userId] ?? false))
          .toList();
    } catch (e) {
      print('Error getting active users: $e');
      return []; // Fallback to empty list
    }
  }

  /// Check if a league has any active users left
  Future<bool> hasActiveUsers(String leagueId) async {
    final activeUsers = await getActiveUsers(leagueId);
    return activeUsers.isNotEmpty;
  }

  /// Get elimination statistics for a league
  Future<EliminationStats> getEliminationStats(String leagueId) async {
    try {
      final league = await _leagueRepository.getLeague(leagueId);
      final eliminatedUsers = await getEliminatedUsers(leagueId);
      final activeUsers = await getActiveUsers(leagueId);
      
      return EliminationStats(
        totalUsers: league.memberIds.length,
        activeUsers: activeUsers.length,
        eliminatedUsers: eliminatedUsers.length,
        eliminationRate: league.memberIds.isNotEmpty 
            ? eliminatedUsers.length / league.memberIds.length 
            : 0.0,
      );
    } catch (e) {
      print('Error getting elimination stats: $e');
      return EliminationStats(
        totalUsers: 0,
        activeUsers: 0,
        eliminatedUsers: 0,
        eliminationRate: 0.0,
      );
    }
  }

}

class EliminationStats {
  final int totalUsers;
  final int activeUsers;
  final int eliminatedUsers;
  final double eliminationRate;

  EliminationStats({
    required this.totalUsers,
    required this.activeUsers,
    required this.eliminatedUsers,
    required this.eliminationRate,
  });
}
