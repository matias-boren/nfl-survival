import 'package:firebase_auth/firebase_auth.dart' as firebase;
import '../models/user.dart';
import 'auth_repositories.dart';

class FirebaseAuthRepository implements AuthRepository {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;

  @override
  Future<User?> currentUser() async {
    final fbUser = _auth.currentUser;
    if (fbUser == null) return null;
    return User(
      id: fbUser.uid,
      displayName: fbUser.displayName ?? 'User',
      email: fbUser.email,
      avatarUrl: fbUser.photoURL,
      isPremium: false, // TODO: check subscription status
      joinedLeagueIds: const [],
    );
  }

  @override
  Future<User> signInAnonymously() async {
    final credential = await _auth.signInAnonymously();
    final fbUser = credential.user!;
    return User(
      id: fbUser.uid,
      displayName: 'Guest',
      isPremium: false,
      joinedLeagueIds: const [],
    );
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final fbUser = credential.user!;
    return User(
      id: fbUser.uid,
      displayName: fbUser.displayName ?? email.split('@').first,
      email: fbUser.email,
      avatarUrl: fbUser.photoURL,
      isPremium: false, // TODO: check subscription status
      joinedLeagueIds: const [],
    );
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
