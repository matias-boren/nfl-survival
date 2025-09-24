import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/user.dart';

abstract class AuthRepository {
  Future<User?> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWithEmail(String email, String password);
  Future<void> signOut();
}

class MockAuthRepository implements AuthRepository {
  static const String _boxName = 'auth';
  static const String _currentKey = 'currentUser';

  Future<Box> _box() async {
    return await Hive.openBox(_boxName);
  }

  @override
  Future<User?> currentUser() async {
    final box = await _box();
    final json = box.get(_currentKey);
    if (json is Map<String, dynamic>) {
      return User.fromJson(json);
    }
    if (json is Map) {
      return User.fromJson(Map<String, dynamic>.from(json));
    }
    return null;
  }

  @override
  Future<User> signInAnonymously() async {
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      displayName: 'Guest',
      isPremium: false,
      joinedLeagueIds: const [],
    );
    final box = await _box();
    await box.put(_currentKey, user.toJson());
    return user;
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    final user = User(
      id: email,
      displayName: email.split('@').first,
      email: email,
      isPremium: false,
      joinedLeagueIds: const [],
    );
    final box = await _box();
    await box.put(_currentKey, user.toJson());
    return user;
  }

  @override
  Future<void> signOut() async {
    final box = await _box();
    await box.delete(_currentKey);
  }
}

