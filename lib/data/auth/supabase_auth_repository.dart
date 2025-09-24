import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nfl_survival/data/auth/auth_repositories.dart';
import 'package:nfl_survival/data/models/user.dart';

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Stream<User?> currentUser() async* {
    await for (final session in _supabase.auth.onAuthStateChange) {
      if (session.session?.user != null) {
        final supabaseUser = session.session!.user;
        yield User(
          id: supabaseUser.id,
          displayName: supabaseUser.userMetadata?['full_name'] ?? 
                      supabaseUser.email?.split('@').first ?? 'User',
          email: supabaseUser.email,
          avatarUrl: supabaseUser.userMetadata?['avatar_url'],
          isPremium: false, // TODO: Check premium status from your database
          joinedLeagueIds: [], // TODO: Load from your database
        );
      } else {
        yield null;
      }
    }
  }

  @override
  Future<User> signInAnonymously() async {
    throw UnsupportedError('Anonymous sign-in is not allowed');
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    
    if (response.user == null) {
      throw Exception('Sign in failed');
    }
    
    return _userFromSupabaseUser(response.user!);
  }

  Future<User> signUpWithEmail(String email, String password, String displayName) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': displayName,
      },
    );
    
    if (response.user == null) {
      throw Exception('Sign up failed');
    }
    
    return _userFromSupabaseUser(response.user!);
  }

  Future<User> signInWithGoogle() async {
    final response = await _supabase.auth.signInWithOAuth(
      Provider.google,
      redirectTo: 'io.supabase.flutterquickstart://login-callback/',
    );
    
    if (response.user == null) {
      throw Exception('Google sign in failed');
    }
    
    return _userFromSupabaseUser(response.user!);
  }

  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  User _userFromSupabaseUser(User supabaseUser) {
    return User(
      id: supabaseUser.id,
      displayName: supabaseUser.userMetadata?['full_name'] ?? 
                  supabaseUser.email?.split('@').first ?? 'User',
      email: supabaseUser.email,
      avatarUrl: supabaseUser.userMetadata?['avatar_url'],
      isPremium: false, // TODO: Check premium status from your database
      joinedLeagueIds: [], // TODO: Load from your database
    );
  }
}
