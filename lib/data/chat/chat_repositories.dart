import 'package:pick1/data/models/chat_message.dart';

abstract class ChatRepository {
  /// Get all chat messages for a league, ordered by creation time (stream)
  Stream<List<ChatMessage>> getChatMessages(String leagueId);
  
  /// Get all chat messages for a league once (one-time fetch)
  Future<List<ChatMessage>> getChatMessagesOnce(String leagueId);

  /// Send a new message to a league
  Future<void> sendMessage({
    required String leagueId,
    required String userId,
    required String userName,
    required String message,
  });

  /// Send a system message to a league
  Future<void> sendSystemMessage({
    required String leagueId,
    required String message,
  });

  /// Delete a message (only if user is the author)
  Future<void> deleteMessage(String messageId, String userId);

  /// Update a message (only if user is the author)
  Future<void> updateMessage({
    required String messageId,
    required String userId,
    required String newMessage,
  });
}
