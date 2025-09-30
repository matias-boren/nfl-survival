import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pick1/data/auth/auth_repositories.dart';
import 'package:pick1/data/models/user.dart' as app_user;

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Stream<app_user.User?> currentUser() async* {
    // First, check if there's already a session
    final currentSession = _supabase.auth.currentSession;
    print(
      '🔍 Initial auth check - Current session: ${currentSession?.user?.email ?? "null"}',
    );

    if (currentSession?.user != null && currentSession?.accessToken != null) {
      print('🔍 Found existing session, loading user data');
      // Load user data for existing session
      final supabaseUser = currentSession!.user;
      List<String> joinedLeagueIds = [];
      bool isPremium = false;
      String? favoriteTeam;
      String displayName =
          supabaseUser.userMetadata?['full_name'] ??
          supabaseUser.email?.split('@').first ??
          'User';

      try {
        // Load joined leagues
        final leaguesResponse = await _supabase
            .from('league_members')
            .select('league_id')
            .eq('user_id', supabaseUser.id);

        joinedLeagueIds = leaguesResponse
            .map((row) => row['league_id'] as String)
            .toList();

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
          print(
            '🔍 Loaded user profile - isPremium: $isPremium, displayName: $displayName',
          );
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
      print('🔍 No existing session, yielding null');
      yield null;
    }

    // Then listen for auth state changes
    await for (final session in _supabase.auth.onAuthStateChange) {
      print(
        '🔍 Auth state change - Session: ${session.session?.user?.email ?? "null"}',
      );
      if (session.session?.user != null &&
          session.session?.accessToken != null) {
        final supabaseUser = session.session!.user;

        // Load joined league IDs and user profile from database
        List<String> joinedLeagueIds = [];
        bool isPremium = false;
        String? favoriteTeam;
        String displayName =
            supabaseUser.userMetadata?['full_name'] ??
            supabaseUser.email?.split('@').first ??
            'User';

        try {
          // Load joined leagues
          final leaguesResponse = await _supabase
              .from('league_members')
              .select('league_id')
              .eq('user_id', supabaseUser.id);

          joinedLeagueIds = leaguesResponse
              .map((row) => row['league_id'] as String)
              .toList();

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
            print(
              '🔍 Loaded user profile - isPremium: $isPremium, displayName: $displayName',
            );
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
        print('🔍 No valid session - yielding null');
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
    String displayName =
        supabaseUser.userMetadata?['full_name'] ??
        supabaseUser.email?.split('@').first ??
        'User';

    try {
      // Load joined leagues
      final leaguesResponse = await _supabase
          .from('league_members')
          .select('league_id')
          .eq('user_id', supabaseUser.id);

      joinedLeagueIds = leaguesResponse
          .map((row) => row['league_id'] as String)
          .toList();

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
        print(
          '🔍 SignIn - Loaded user profile - isPremium: $isPremium, displayName: $displayName',
        );
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
  Future<app_user.User> signUpWithEmail(
    String email,
    String password,
    String displayName,
    String favoriteTeam,
  ) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': displayName},
    );

    if (response.user == null) {
      throw Exception('Sign up failed');
    }

    // Create user profile in database with retry logic
    bool profileCreated = false;
    int retryCount = 0;
    const maxRetries = 3;

    while (!profileCreated && retryCount < maxRetries) {
      try {
        await _supabase.from('user_profiles').insert({
          'user_id': response.user!.id,
          'display_name': displayName,
          'favorite_team': favoriteTeam,
          'is_premium': false, // New users start as freemium
        });
        profileCreated = true;
        print('✅ User profile created successfully for: ${response.user!.id}');
      } catch (e) {
        retryCount++;
        print(
          '⚠️ Error creating user profile (attempt $retryCount/$maxRetries): $e',
        );

        if (retryCount < maxRetries) {
          // Wait a bit before retrying
          await Future.delayed(Duration(seconds: 1));
        } else {
          print(
            '❌ Failed to create user profile after $maxRetries attempts. User will be created by database trigger.',
          );
          // Don't throw error - the database trigger will handle it
        }
      }
    }

    return _userFromSupabaseUser(response.user!);
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
  Future<app_user.User> updateUser({
    String? displayName,
    String? favoriteTeam,
  }) async {
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
      await _supabase.auth.updateUser(UserAttributes(data: updates));
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
      await _supabase.from('user_profiles').upsert({
        'user_id': currentUser.id,
        ...profileUpdates,
      });
    }

    return _userFromSupabaseUser(currentUser);
  }

  // Method to update premium status (for admin/testing purposes)
  Future<void> updatePremiumStatus(bool isPremium) async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      throw Exception('No authenticated user');
    }

    await _supabase.from('user_profiles').upsert({
      'user_id': currentUser.id,
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
      displayName:
          supabaseUser.userMetadata?['full_name'] ??
          supabaseUser.email?.split('@').first ??
          'User',
      email: supabaseUser.email,
      avatarUrl: supabaseUser.userMetadata?['avatar_url'],
      isPremium: false, // This will be updated by the currentUser stream
      joinedLeagueIds: [], // This will be updated by the currentUser stream
      favoriteTeam: supabaseUser.userMetadata?['favorite_team'],
    );
  }
}
