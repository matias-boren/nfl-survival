import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pick1/data/chat/chat_repositories.dart';
import 'package:pick1/data/models/chat_message.dart';

class SupabaseChatRepository implements ChatRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Stream<List<ChatMessage>> getChatMessages(String leagueId) {
    print('🔍 Setting up chat stream for league: $leagueId');

    // For now, let's use a periodic refresh instead of real-time
    // This will help us debug if the issue is with real-time subscriptions
    return Stream.periodic(const Duration(seconds: 2), (_) async {
      print('🔄 Fetching messages for league $leagueId');
      final response = await _supabase
          .from('chat_messages')
          .select()
          .eq('league_id', leagueId)
          .order('created_at', ascending: true);

      print('📨 Fetched ${response.length} messages for league $leagueId');
      return response.map((row) => _chatMessageFromSupabase(row)).toList();
    }).asyncMap((future) => future);
  }

  /// Get user's display name from user_profiles table
  Future<String> _getUserDisplayName(String userId) async {
    try {
      final userProfile = await _supabase
          .from('user_profiles')
          .select('display_name')
          .eq('user_id', userId)
          .single();

      return userProfile['display_name'] ?? 'Unknown User';
    } catch (e) {
      print('⚠️ Could not fetch display name for user $userId: $e');
      return 'User ${userId.substring(0, 8)}';
    }
  }

  @override
  Future<void> sendMessage({
    required String leagueId,
    required String userId,
    required String userName,
    required String message,
  }) async {
    print('📤 Sending message to league $leagueId: $message');

    // Get the user's display name from user_profiles table
    final displayName = await _getUserDisplayName(userId);
    print('👤 Using display name: $displayName');

    final result = await _supabase.from('chat_messages').insert({
      'league_id': leagueId,
      'user_id': userId,
      'user_name': displayName,
      'message': message,
      'is_system_message': false,
    });
    print('✅ Message sent successfully: $result');
  }

  @override
  Future<void> sendSystemMessage({
    required String leagueId,
    required String message,
  }) async {
    print('🤖 Sending system message to league $leagueId: $message');
    await _supabase.from('chat_messages').insert({
      'league_id': leagueId,
      'user_id':
          '00000000-0000-0000-0000-000000000000', // Special UUID for system messages
      'user_name': 'System',
      'message': message,
      'is_system_message': true,
    });
    print('✅ System message sent successfully');
  }

  @override
  Future<void> deleteMessage(String messageId, String userId) async {
    await _supabase
        .from('chat_messages')
        .delete()
        .eq('id', messageId)
        .eq('user_id', userId);
  }

  @override
  Future<void> updateMessage({
    required String messageId,
    required String userId,
    required String newMessage,
  }) async {
    await _supabase
        .from('chat_messages')
        .update({
          'message': newMessage,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', messageId)
        .eq('user_id', userId);
  }

  ChatMessage _chatMessageFromSupabase(Map<String, dynamic> data) {
    return ChatMessage(
      id: data['id'],
      leagueId: data['league_id'],
      userId: data['user_id'],
      userName: data['user_name'] ?? 'Unknown User',
      message: data['message'],
      createdAt: DateTime.parse(data['created_at']),
      isSystemMessage: data['is_system_message'] ?? false,
    );
  }
}
