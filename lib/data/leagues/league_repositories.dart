import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/league.dart';
import '../../data/models/user.dart';

abstract class LeagueRepository {
  Future<League> createLeague(League draft);
  Future<List<League>> listLeaguesForUser(String userId);
  Future<League> getLeague(String leagueId);
  Future<void> joinLeagueByCode(String inviteCode);
  Future<void> joinPublicLeague(String leagueId);
  Stream<List<User>> leagueMembers(String leagueId);
}

class MockLeagueRepository implements LeagueRepository {
  static const String _boxName = 'leagues';
  static const String _membersBox = 'league_members';

  Future<Box> _box() async => Hive.openBox(_boxName);
  Future<Box> _mBox() async => Hive.openBox(_membersBox);

  @override
  Future<League> createLeague(League draft) async {
    final box = await _box();
    await box.put(draft.id, draft.toJson());
    return draft;
  }

  @override
  Future<League> getLeague(String leagueId) async {
    final box = await _box();
    final json = box.get(leagueId) as Map?;
    if (json == null) throw Exception('League not found');
    return League.fromJson(Map<String, dynamic>.from(json));
  }

  @override
  Future<void> joinLeagueByCode(String inviteCode) async {}

  @override
  Future<void> joinPublicLeague(String leagueId) async {}

  @override
  Future<List<League>> listLeaguesForUser(String userId) async {
    final box = await _box();
    return box.values
        .whereType<Map>()
        .map((e) => League.fromJson(Map<String, dynamic>.from(e)))
        .where((l) => l.memberIds.contains(userId))
        .toList();
  }

  @override
  Stream<List<User>> leagueMembers(String leagueId) async* {
    final box = await _mBox();
    final List list = box.get(leagueId) as List? ?? [];
    yield list
        .whereType<Map>()
        .map((e) => User.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}

