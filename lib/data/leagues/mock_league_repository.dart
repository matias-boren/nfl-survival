import 'dart:async';
import 'package:nfl_survival/data/leagues/league_repositories.dart';
import 'package:nfl_survival/data/models/league.dart';
import 'package:nfl_survival/data/models/user.dart';

class MockLeagueRepository implements LeagueRepository {
  // In-memory storage for testing
  static final List<League> _leagues = [
    // Sample public leagues for testing
    League(
      id: 'public_league_1',
      name: 'NFL Survivors 2025',
      ownerId: 'owner_1',
      visibility: LeagueVisibility.PUBLIC,
      settings: const LeagueSettings(
        maxLosses: 3,
        allowTeamReuse: false,
        autoEliminateOnNoPick: true,
      ),
      season: 2025,
      createdAtIso: '2025-01-01T00:00:00Z',
      memberIds: ['owner_1', 'member_1', 'member_2'],
    ),
    League(
      id: 'public_league_2',
      name: 'Championship Challenge',
      ownerId: 'owner_2',
      visibility: LeagueVisibility.PUBLIC,
      settings: const LeagueSettings(
        maxLosses: 2,
        allowTeamReuse: true,
        autoEliminateOnNoPick: false,
      ),
      season: 2025,
      createdAtIso: '2025-01-02T00:00:00Z',
      memberIds: ['owner_2', 'member_3', 'member_4', 'member_5'],
    ),
    League(
      id: 'public_league_3',
      name: 'Survival Masters',
      ownerId: 'owner_3',
      visibility: LeagueVisibility.PUBLIC,
      settings: const LeagueSettings(
        maxLosses: 1,
        allowTeamReuse: false,
        autoEliminateOnNoPick: true,
      ),
      season: 2025,
      createdAtIso: '2025-01-03T00:00:00Z',
      memberIds: ['owner_3', 'member_6'],
    ),
    League(
      id: 'public_league_4',
      name: 'Weekend Warriors',
      ownerId: 'owner_4',
      visibility: LeagueVisibility.PUBLIC,
      settings: const LeagueSettings(
        maxLosses: 4,
        allowTeamReuse: true,
        autoEliminateOnNoPick: false,
      ),
      season: 2025,
      createdAtIso: '2025-01-04T00:00:00Z',
      memberIds: ['owner_4', 'member_7', 'member_8', 'member_9', 'member_10'],
    ),
    League(
      id: 'public_league_5',
      name: 'Elite Survivors',
      ownerId: 'owner_5',
      visibility: LeagueVisibility.PUBLIC,
      settings: const LeagueSettings(
        maxLosses: 2,
        allowTeamReuse: false,
        autoEliminateOnNoPick: true,
      ),
      season: 2025,
      createdAtIso: '2025-01-05T00:00:00Z',
      memberIds: [
        'owner_5',
        'member_11',
        'member_12',
        'member_13',
        'member_14',
        'member_15',
      ],
    ),
  ];

  @override
  Future<League> createLeague(League draft) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate network delay

    final newLeague = draft.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _leagues.add(newLeague);
    return newLeague;
  }

  @override
  Future<List<League>> listLeaguesForUser(String userId) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    ); // Simulate network delay

    return _leagues
        .where((league) => league.memberIds.contains(userId))
        .toList();
  }

  @override
  Future<League> getLeague(String leagueId) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    ); // Simulate network delay

    try {
      return _leagues.firstWhere((league) => league.id == leagueId);
    } catch (e) {
      throw Exception('League not found');
    }
  }

  @override
  Future<void> joinLeagueByCode(String inviteCode) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock implementation
  }

  @override
  Future<void> joinPublicLeague(String leagueId) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock implementation
  }

  @override
  Future<void> joinLeague(String leagueId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final leagueIndex = _leagues.indexWhere((league) => league.id == leagueId);
    if (leagueIndex == -1) {
      throw Exception('League not found');
    }

    final league = _leagues[leagueIndex];
    if (league.memberIds.contains(userId)) {
      throw Exception('User is already a member of this league');
    }

    // Add user to league members
    final updatedLeague = league.copyWith(
      memberIds: [...league.memberIds, userId],
    );
    _leagues[leagueIndex] = updatedLeague;
  }

  @override
  Future<void> leaveLeague(String leagueId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final leagueIndex = _leagues.indexWhere((league) => league.id == leagueId);
    if (leagueIndex == -1) {
      throw Exception('League not found');
    }

    final league = _leagues[leagueIndex];
    if (!league.memberIds.contains(userId)) {
      throw Exception('User is not a member of this league');
    }

    // Remove user from league members
    final updatedLeague = league.copyWith(
      memberIds: league.memberIds.where((id) => id != userId).toList(),
    );
    _leagues[leagueIndex] = updatedLeague;
  }

  @override
  Future<List<League>> getPublicLeagues() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _leagues
        .where((league) => league.visibility == LeagueVisibility.PUBLIC)
        .toList();
  }

  @override
  Future<List<League>> listLeagues([String? userId]) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (userId != null) {
      // Get leagues for a specific user
      return listLeaguesForUser(userId);
    }

    // Get all leagues (for system processing)
    return List.from(_leagues);
  }

  @override
  Stream<List<User>> leagueMembers(String leagueId) async* {
    // Mock implementation - return empty list for now
    yield [];
  }

  @override
  Future<void> updateLeague(League league) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _leagues.indexWhere((l) => l.id == league.id);
    if (index != -1) {
      _leagues[index] = league;
    } else {
      throw Exception('League not found');
    }
  }

  @override
  Future<void> deleteLeague(String leagueId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    _leagues.removeWhere((league) => league.id == leagueId);
  }
}
