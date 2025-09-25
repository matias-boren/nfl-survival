import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nfl_survival/data/auth/auth_repositories.dart';
import 'package:nfl_survival/data/models/user.dart' as app_user;

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Stream<app_user.User?> currentUser() async* {
    await for (final session in _supabase.auth.onAuthStateChange) {
      if (session.session?.user != null) {
        final supabaseUser = session.session!.user;
        yield app_user.User(
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
  Future<app_user.User> signInWithEmail(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    
    if (response.user == null) {
      throw Exception('Sign in failed');
    }
    
    return _userFromSupabaseUser(response.user!);
  }

  @override
  Future<app_user.User> signUpWithEmail(String email, String password, String displayName) async {
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

  @override
  Future<app_user.User> signInWithGoogle() async {
    final response = await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.flutterquickstart://login-callback/',
    );
    
    // For OAuth, we need to wait for the auth state change
    // This is a simplified implementation
    throw Exception('Google sign in not yet implemented - please use email/password for now');
  }

  @override
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  app_user.User _userFromSupabaseUser(User supabaseUser) {
    return app_user.User(
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
