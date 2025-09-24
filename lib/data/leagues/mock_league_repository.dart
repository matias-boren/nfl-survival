import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nfl_survival/data/leagues/league_repositories.dart';
import 'package:nfl_survival/data/models/league.dart';
import 'package:nfl_survival/data/models/user.dart';
import 'package:uuid/uuid.dart';

class MockLeagueRepository implements LeagueRepository {
  static const _leagueBoxName = 'leagueBox';
  final Uuid _uuid = const Uuid();

  Future<Box<String>> _openLeagueBox() => Hive.openBox<String>(_leagueBoxName);

  @override
  Future<League> createLeague(League draft) async {
    final newLeague = draft.copyWith(id: _uuid.v4());
    final box = await _openLeagueBox();
    await box.put(newLeague.id, newLeague.toJson().toString());
    return newLeague;
  }

  @override
  Future<List<League>> listLeaguesForUser(String userId) async {
    final box = await _openLeagueBox();
    return box.values
        .map((jsonString) => League.fromJson(Map<String, dynamic>.from(jsonString as Map)))
        .where((league) => league.memberIds.contains(userId))
        .toList();
  }

  @override
  Future<League> getLeague(String leagueId) async {
    final box = await _openLeagueBox();
    final leagueJson = box.get(leagueId);
    if (leagueJson != null) {
      return League.fromJson(Map<String, dynamic>.from(leagueJson as Map));
    }
    throw Exception('League not found');
  }

  @override
  Future<void> joinLeagueByCode(String inviteCode) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> joinPublicLeague(String leagueId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Stream<List<User>> leagueMembers(String leagueId) {
    return Stream.value([
      const User(id: '1', displayName: 'Alice', isPremium: false, joinedLeagueIds: []),
      const User(id: '2', displayName: 'Bob', isPremium: true, joinedLeagueIds: []),
    ]);
  }
}
