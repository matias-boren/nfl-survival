import 'package:hive_flutter/hive_flutter.dart';
import 'package:nfl_survival/data/auth/auth_repositories.dart';
import 'package:nfl_survival/data/models/user.dart';
import 'package:uuid/uuid.dart';

class MockAuthRepository implements AuthRepository {
  static const _userBoxName = 'userBox';
  static const _currentUserKey = 'currentUser';
  final Uuid _uuid = const Uuid();

  Future<Box<String>> _openUserBox() => Hive.openBox<String>(_userBoxName);

  @override
  Stream<User?> currentUser() async* {
    final box = await _openUserBox();
    final userJson = box.get(_currentUserKey);
    if (userJson != null) {
      yield User.fromJson(Map<String, dynamic>.from(userJson as Map));
    } else {
      yield null;
    }
  }

  @override
  Future<User> signInAnonymously() async {
    final user = User(
      id: _uuid.v4(),
      displayName: 'Guest User',
      isPremium: false,
      joinedLeagueIds: [],
    );
    final box = await _openUserBox();
    await box.put(_currentUserKey, user.toJson().toString());
    return user;
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    final user = User(
      id: _uuid.v4(),
      displayName: email.split('@').first,
      email: email,
      isPremium: false,
      joinedLeagueIds: [],
    );
    final box = await _openUserBox();
    await box.put(_currentUserKey, user.toJson().toString());
    return user;
  }

  @override
  Future<void> signOut() async {
    final box = await _openUserBox();
    await box.delete(_currentUserKey);
  }
}
