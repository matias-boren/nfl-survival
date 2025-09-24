import 'package:nfl_survival/data/models/user.dart';

abstract class AuthRepository {
  Stream<User?> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWithEmail(String email, String password);
  Future<void> signOut();
}
