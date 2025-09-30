import 'dart:async';
import 'package:pick1/data/auth/auth_repositories.dart';
import 'package:pick1/data/models/user.dart';

class MockAuthRepository implements AuthRepository {
  final _userStreamController = StreamController<User?>.broadcast();
  User? _currentUser;

  MockAuthRepository() {
    _userStreamController.add(null); // Start with no user
  }

  @override
  Stream<User?> currentUser() => _userStreamController.stream;

  @override
  Future<User> signInWithEmail(String email, String password) async {
    print('MockAuthRepository.signInWithEmail called');
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      displayName: email.split('@').first,
      email: email,
      isPremium: false,
      joinedLeagueIds: [],
    );

    _currentUser = user;
    print(
      'MockAuthRepository.signInWithEmail adding user to stream: ${user.displayName}',
    );
    _userStreamController.add(user);
    return user;
  }

  @override
  Future<User> signUpWithEmail(
    String email,
    String password,
    String displayName,
    String favoriteTeam,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      displayName: displayName,
      email: email,
      isPremium: false,
      joinedLeagueIds: [],
      favoriteTeam: favoriteTeam,
    );

    _currentUser = user;
    _userStreamController.add(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _userStreamController.add(null);
  }

  @override
  Future<User> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      displayName: 'Google User',
      email: 'google@example.com',
      isPremium: false,
      joinedLeagueIds: [],
    );

    _currentUser = user;
    _userStreamController.add(user);
    return user;
  }

  @override
  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock: Simulate password reset email sent
  }

  @override
  Future<User> updateUser({String? displayName, String? favoriteTeam}) async {
    if (_currentUser == null) {
      throw Exception('No user is currently signed in');
    }

    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate network delay

    // Update the current user with new data
    final updatedUser = _currentUser!.copyWith(
      displayName: displayName ?? _currentUser!.displayName,
      favoriteTeam: favoriteTeam ?? _currentUser!.favoriteTeam,
    );

    _currentUser = updatedUser;
    _userStreamController.add(updatedUser);
    return updatedUser;
  }

  @override
  Future<void> updatePremiumStatus(bool isPremium) async {
    if (_currentUser == null) {
      throw Exception('No user is currently signed in');
    }

    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate network delay

    // Update the current user's premium status
    final updatedUser = _currentUser!.copyWith(isPremium: isPremium);
    _currentUser = updatedUser;
    _userStreamController.add(updatedUser);
  }
}
