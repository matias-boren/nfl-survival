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
        
        // Load joined league IDs and user profile from database
        List<String> joinedLeagueIds = [];
        bool isPremium = false;
        String? favoriteTeam;
        String displayName = supabaseUser.userMetadata?['full_name'] ?? 
                            supabaseUser.email?.split('@').first ?? 'User';
        
        try {
          // Load joined leagues
          final leaguesResponse = await _supabase
              .from('league_members')
              .select('league_id')
              .eq('user_id', supabaseUser.id);
          
          joinedLeagueIds = leaguesResponse.map((row) => row['league_id'] as String).toList();
          
          // Load user profile
          final profileResponse = await _supabase
              .from('user_profiles')
              .select('display_name, favorite_team, is_premium')
              .eq('user_id', supabaseUser.id)
              .maybeSingle();
          
          if (profileResponse != null) {
            displayName = profileResponse['display_name'] ?? displayName;
            favoriteTeam = profileResponse['favorite_team'];
            isPremium = profileResponse['is_premium'] ?? false;
            print('🔍 Loaded user profile - isPremium: $isPremium, displayName: $displayName');
          } else {
            print('⚠️ No user profile found for user: ${supabaseUser.id}');
          }
        } catch (e) {
          print('Error loading user data: $e');
        }
        
        yield app_user.User(
          id: supabaseUser.id,
          displayName: displayName,
          email: supabaseUser.email,
          avatarUrl: supabaseUser.userMetadata?['avatar_url'],
          isPremium: isPremium,
          joinedLeagueIds: joinedLeagueIds,
          favoriteTeam: favoriteTeam,
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
    
    // Load user data from database (same as currentUser method)
    final supabaseUser = response.user!;
    List<String> joinedLeagueIds = [];
    bool isPremium = false;
    String? favoriteTeam;
    String displayName = supabaseUser.userMetadata?['full_name'] ?? 
                        supabaseUser.email?.split('@').first ?? 'User';
    
    try {
      // Load joined leagues
      final leaguesResponse = await _supabase
          .from('league_members')
          .select('league_id')
          .eq('user_id', supabaseUser.id);
      
      joinedLeagueIds = leaguesResponse.map((row) => row['league_id'] as String).toList();
      
      // Load user profile
      final profileResponse = await _supabase
          .from('user_profiles')
          .select('display_name, favorite_team, is_premium')
          .eq('user_id', supabaseUser.id)
          .maybeSingle();
      
      if (profileResponse != null) {
        displayName = profileResponse['display_name'] ?? displayName;
        favoriteTeam = profileResponse['favorite_team'];
        isPremium = profileResponse['is_premium'] ?? false;
        print('🔍 SignIn - Loaded user profile - isPremium: $isPremium, displayName: $displayName');
      } else {
        print('⚠️ SignIn - No user profile found for user: ${supabaseUser.id}');
      }
    } catch (e) {
      print('Error loading user data during sign in: $e');
    }
    
    return app_user.User(
      id: supabaseUser.id,
      displayName: displayName,
      email: supabaseUser.email,
      avatarUrl: supabaseUser.userMetadata?['avatar_url'],
      isPremium: isPremium,
      joinedLeagueIds: joinedLeagueIds,
      favoriteTeam: favoriteTeam,
    );
  }

  @override
  Future<app_user.User> signUpWithEmail(String email, String password, String displayName, String favoriteTeam) async {
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
    
    // Create user profile in database
    try {
      await _supabase.from('user_profiles').insert({
        'user_id': response.user!.id,
        'display_name': displayName,
        'favorite_team': favoriteTeam,
        'is_premium': false, // New users start as freemium
      });
    } catch (e) {
      print('Error creating user profile: $e');
      // Continue anyway - the user is created in auth, profile can be created later
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

  @override
  Future<app_user.User> updateUser({String? displayName, String? favoriteTeam}) async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      throw Exception('No user logged in');
    }

    // Update user metadata
    final updates = <String, dynamic>{};
    if (displayName != null) {
      updates['full_name'] = displayName;
    }
    if (favoriteTeam != null) {
      updates['favorite_team'] = favoriteTeam;
    }

    if (updates.isNotEmpty) {
      await _supabase.auth.updateUser(
        UserAttributes(data: updates),
      );
    }

    // Update user profile in database
    final profileUpdates = <String, dynamic>{};
    if (displayName != null) {
      profileUpdates['display_name'] = displayName;
    }
    if (favoriteTeam != null) {
      profileUpdates['favorite_team'] = favoriteTeam;
    }

    if (profileUpdates.isNotEmpty) {
      profileUpdates['updated_at'] = DateTime.now().toIso8601String();
      await _supabase
          .from('user_profiles')
          .upsert({
            'user_id': currentUser.id,
            ...profileUpdates,
          });
    }

    return _userFromSupabaseUser(currentUser);
  }

  // Method to update premium status (for admin/testing purposes)
  Future<void> updatePremiumStatus(String userId, bool isPremium) async {
    await _supabase
        .from('user_profiles')
        .upsert({
          'user_id': userId,
          'is_premium': isPremium,
          'updated_at': DateTime.now().toIso8601String(),
        });
  }

  // Method to refresh current user data (useful for testing)
  Future<void> refreshCurrentUser() async {
    // This will trigger the auth state change and reload user data
    final currentUser = _supabase.auth.currentUser;
    if (currentUser != null) {
      // Force a refresh by getting the user again
      await _supabase.auth.getUser();
    }
  }

  app_user.User _userFromSupabaseUser(User supabaseUser) {
    return app_user.User(
      id: supabaseUser.id,
      displayName: supabaseUser.userMetadata?['full_name'] ?? 
                  supabaseUser.email?.split('@').first ?? 'User',
      email: supabaseUser.email,
      avatarUrl: supabaseUser.userMetadata?['avatar_url'],
      isPremium: false, // This will be updated by the currentUser stream
      joinedLeagueIds: [], // This will be updated by the currentUser stream
      favoriteTeam: supabaseUser.userMetadata?['favorite_team'],
    );
  }
}
