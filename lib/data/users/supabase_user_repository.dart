import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pick1/data/users/user_repositories.dart';
import 'package:pick1/data/models/user.dart' as pick1_user;

class SupabaseUserRepository implements UserRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<pick1_user.User?> getUserById(String userId) async {
    try {
      final response = await _supabase
          .from('users')
          .select('*')
          .eq('id', userId)
          .single();

      return pick1_user.User(
        id: response['id'],
        displayName: response['display_name'] ?? 'User',
        email: response['email'] ?? '',
        isPremium: response['is_premium'] ?? false,
        joinedLeagueIds: List<String>.from(response['joined_league_ids'] ?? []),
        favoriteTeam: response['favorite_team'] ?? 'Kansas City Chiefs',
      );
    } catch (e) {
      print('Error getting user by ID: $e');
      return null;
    }
  }

  @override
  Future<List<pick1_user.User>> getUsersByIds(List<String> userIds) async {
    try {
      if (userIds.isEmpty) return [];

      final response = await _supabase
          .from('users')
          .select('*')
          .inFilter('id', userIds);

      return response.map<pick1_user.User>((data) => pick1_user.User(
        id: data['id'],
        displayName: data['display_name'] ?? 'User',
        email: data['email'] ?? '',
        isPremium: data['is_premium'] ?? false,
        joinedLeagueIds: List<String>.from(data['joined_league_ids'] ?? []),
        favoriteTeam: data['favorite_team'] ?? 'Kansas City Chiefs',
      )).toList();
    } catch (e) {
      print('Error getting users by IDs: $e');
      return [];
    }
  }
}
