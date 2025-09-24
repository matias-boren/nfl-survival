import 'package:nfl_survival/data/auth/auth_repositories.dart';
import 'package:nfl_survival/data/models/user.dart';

class FirebaseAuthRepository implements AuthRepository {
  @override
  Stream<User?> currentUser() async* {
    // TODO: Implement Firebase Auth when dependency is added
    yield null;
  }

  @override
  Future<User> signInAnonymously() async {
    // TODO: Implement Firebase Auth when dependency is added
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    // TODO: Implement Firebase Auth when dependency is added
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    // TODO: Implement Firebase Auth when dependency is added
  }
}
