import 'dart:async';
import '../../data/models/user.dart';

abstract class FriendsRepository {
  Future<void> sendRequest(String fromUserId, String toUserId);
  Future<void> acceptRequest(String fromUserId, String toUserId);
  Stream<List<User>> friends(String userId);
}

class MockFriendsRepository implements FriendsRepository {
  final Map<String, Set<String>> _friends = {};
  final _controllers = <String, StreamController<List<User>>>{};

  @override
  Future<void> sendRequest(String fromUserId, String toUserId) async {
    // In mock, auto-accept for simplicity
    await acceptRequest(fromUserId, toUserId);
  }

  @override
  Future<void> acceptRequest(String fromUserId, String toUserId) async {
    _friends.putIfAbsent(fromUserId, () => <String>{}).add(toUserId);
    _friends.putIfAbsent(toUserId, () => <String>{}).add(fromUserId);
    _emit(fromUserId);
    _emit(toUserId);
  }

  void _emit(String userId) {
    final controller = _controllers[userId];
    if (controller == null) return;
    final ids = _friends[userId] ?? {};
    controller.add(ids.map((id) => User(id: id, displayName: id, isPremium: false, joinedLeagueIds: const [])).toList());
  }

  @override
  Stream<List<User>> friends(String userId) {
    final controller = _controllers.putIfAbsent(userId, () => StreamController<List<User>>.broadcast());
    _emit(userId);
    return controller.stream;
  }
}

