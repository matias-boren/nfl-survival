import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nfl_survival/data/auth/auth_repositories.dart';
import 'package:nfl_survival/data/models/user.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Stream<User?> currentUser() async* {
    await for (final firebaseUser in _firebaseAuth.authStateChanges()) {
      if (firebaseUser != null) {
        yield User(
          id: firebaseUser.uid,
          displayName: firebaseUser.displayName ?? 'User',
          email: firebaseUser.email,
          avatarUrl: firebaseUser.photoURL,
          isPremium: false, // TODO: Check premium status from your backend
          joinedLeagueIds: [], // TODO: Load from your backend
        );
      } else {
        yield null;
      }
    }
  }

  @override
  Future<User> signInAnonymously() async {
    final credential = await _firebaseAuth.signInAnonymously();
    return _userFromFirebaseUser(credential.user!);
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebaseUser(credential.user!);
  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    
    if (googleUser == null) {
      throw Exception('Google sign in was cancelled');
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google credential
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return _userFromFirebaseUser(userCredential.user!);
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  User _userFromFirebaseUser(firebase_auth.User firebaseUser) {
    return User(
      id: firebaseUser.uid,
      displayName: firebaseUser.displayName ?? 'User',
      email: firebaseUser.email,
      avatarUrl: firebaseUser.photoURL,
      isPremium: false, // TODO: Check premium status from your backend
      joinedLeagueIds: [], // TODO: Load from your backend
    );
  }
}
