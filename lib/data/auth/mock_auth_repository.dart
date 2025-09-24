import 'package:hive_flutter/hive_flutter.dart';
import 'package:nfl_survival/data/auth/auth_repositories.dart';
import 'package:nfl_survival/data/models/user.dart';

class MockAuthRepository implements AuthRepository {
  static const _userBoxName = 'userBox';
  static const _currentUserKey = 'currentUser';

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
  Future<User> signInWithEmail(String email, String password) async {
    // Mock: Always create a new user for demo purposes
    final user = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
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
  Future<User> signUpWithEmail(String email, String password, String displayName) async {
    final user = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      displayName: displayName,
      email: email,
      isPremium: false,
      joinedLeagueIds: [],
    );
    final box = await _openUserBox();
    await box.put(_currentUserKey, user.toJson().toString());
    return user;
  }

  @override
  Future<User> signInWithGoogle() async {
    // Mock: Create a user with Google-like data
    final user = User(
      id: 'google_user_${DateTime.now().millisecondsSinceEpoch}',
      displayName: 'Google User',
      email: 'user@gmail.com',
      avatarUrl: 'https://via.placeholder.com/150',
      isPremium: false,
      joinedLeagueIds: [],
    );
    final box = await _openUserBox();
    await box.put(_currentUserKey, user.toJson().toString());
    return user;
  }

  @override
  Future<void> resetPassword(String email) async {
    // Mock: Simulate password reset
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> signOut() async {
    final box = await _openUserBox();
    await box.delete(_currentUserKey);
  }
}
