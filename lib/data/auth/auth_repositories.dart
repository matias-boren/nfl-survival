import 'package:nfl_survival/data/models/user.dart';

abstract class AuthRepository {
  Stream<User?> currentUser();
  Future<User> signInWithEmail(String email, String password);
  Future<User> signUpWithEmail(
    String email,
    String password,
    String displayName,
    String favoriteTeam,
  );
  Future<User> signInWithGoogle();
  Future<void> resetPassword(String email);
  Future<void> signOut();
  Future<User> updateUser({String? displayName, String? favoriteTeam});
  Future<void> updatePremiumStatus(bool isPremium);
}
