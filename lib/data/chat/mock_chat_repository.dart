import 'dart:async';
import 'package:nfl_survival/data/chat/chat_repositories.dart';
import 'package:nfl_survival/data/models/chat_message.dart';

class MockChatRepository implements ChatRepository {
  static final Map<String, List<ChatMessage>> _messages = {};
  static final Map<String, StreamController<List<ChatMessage>>> _streamControllers = {};

  @override
  Stream<List<ChatMessage>> getChatMessages(String leagueId) {
    if (!_streamControllers.containsKey(leagueId)) {
      _streamControllers[leagueId] = StreamController<List<ChatMessage>>.broadcast();
      _messages[leagueId] = [];
      
      // Add some mock messages
      _addMockMessages(leagueId);
    }
    
    return _streamControllers[leagueId]!.stream;
  }

  @override
  Future<void> sendMessage({
    required String leagueId,
    required String userId,
    required String userName,
    required String message,
  }) async {
    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      leagueId: leagueId,
      userId: userId,
      userName: userName,
      message: message,
      createdAt: DateTime.now(),
      isSystemMessage: false,
    );
    
    _messages[leagueId]?.add(newMessage);
    _streamControllers[leagueId]?.add(List.from(_messages[leagueId]!));
  }

  @override
  Future<void> sendSystemMessage({
    required String leagueId,
    required String message,
  }) async {
    final systemMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      leagueId: leagueId,
      userId: 'system',
      userName: 'System',
      message: message,
      createdAt: DateTime.now(),
      isSystemMessage: true,
    );
    
    _messages[leagueId]?.add(systemMessage);
    _streamControllers[leagueId]?.add(List.from(_messages[leagueId]!));
  }

  @override
  Future<void> deleteMessage(String messageId, String userId) async {
    // Find and remove the message
    for (final leagueMessages in _messages.values) {
      leagueMessages.removeWhere((msg) => msg.id == messageId && msg.userId == userId);
    }
    
    // Update all streams
    for (final controller in _streamControllers.values) {
      controller.add(List.from(_messages[controller.hashCode.toString()] ?? []));
    }
  }

  @override
  Future<void> updateMessage({
    required String messageId,
    required String userId,
    required String newMessage,
  }) async {
    // Find and update the message
    for (final leagueMessages in _messages.values) {
      final messageIndex = leagueMessages.indexWhere(
        (msg) => msg.id == messageId && msg.userId == userId,
      );
      
      if (messageIndex != -1) {
        leagueMessages[messageIndex] = leagueMessages[messageIndex].copyWith(
          message: newMessage,
        );
      }
    }
    
    // Update all streams
    for (final controller in _streamControllers.values) {
      controller.add(List.from(_messages[controller.hashCode.toString()] ?? []));
    }
  }

  void _addMockMessages(String leagueId) {
    final mockMessages = [
      ChatMessage(
        id: '1',
        leagueId: leagueId,
        userId: 'user1',
        userName: 'Alice',
        message: 'Good luck everyone! 🏈',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        isSystemMessage: false,
      ),
      ChatMessage(
        id: '2',
        leagueId: leagueId,
        userId: 'user2',
        userName: 'Bob',
        message: 'Who are you picking this week?',
        createdAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
        isSystemMessage: false,
      ),
      ChatMessage(
        id: '3',
        leagueId: leagueId,
        userId: 'system',
        userName: 'System',
        message: 'Bob joined the league',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        isSystemMessage: true,
      ),
      ChatMessage(
        id: '4',
        leagueId: leagueId,
        userId: 'user3',
        userName: 'Charlie',
        message: 'I\'m going with the Chiefs this week',
        createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
        isSystemMessage: false,
      ),
      ChatMessage(
        id: '5',
        leagueId: leagueId,
        userId: 'user1',
        userName: 'Alice',
        message: 'Smart pick! They\'re looking strong',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        isSystemMessage: false,
      ),
    ];
    
    _messages[leagueId] = mockMessages;
    _streamControllers[leagueId]?.add(List.from(mockMessages));
  }

  void dispose() {
    for (final controller in _streamControllers.values) {
      controller.close();
    }
    _streamControllers.clear();
    _messages.clear();
  }
}
