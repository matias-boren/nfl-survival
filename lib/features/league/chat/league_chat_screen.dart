import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick1/app/providers.dart';
import 'package:pick1/widgets/app_scaffold.dart';
import 'package:pick1/widgets/banner_ad_slot.dart';
import 'package:pick1/data/models/chat_message.dart';

class LeagueChatScreen extends ConsumerStatefulWidget {
  final String leagueId;
  const LeagueChatScreen({super.key, required this.leagueId});

  @override
  ConsumerState<LeagueChatScreen> createState() => _LeagueChatScreenState();
}

class _LeagueChatScreenState extends ConsumerState<LeagueChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Refresh chat messages when entering the screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(leagueChatProvider(widget.leagueId));
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatAsync = ref.watch(leagueChatProvider(widget.leagueId));
    final isPremium = ref.watch(premiumStatusProvider);

    print('🏗️ Building chat screen for league: ${widget.leagueId}');
    print(
      '📊 Chat state: ${chatAsync.when(data: (messages) => '${messages.length} messages', loading: () => 'loading', error: (e, st) => 'error: $e')}',
    );

    return AppScaffold(
      appBar: AppBar(
        title: const Text('League Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('League Chat'),
                  content: const Text(
                    'Chat with your league members! Share strategies, trash talk, and celebrate victories together.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Got it'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: chatAsync.when(
              data: (messages) {
                if (messages.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(leagueChatProvider(widget.leagueId));
                    },
                    child: const SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: 400,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 64,
                                color: Color(0xFF76ABAE), // Our accent color
                              ),
                              SizedBox(height: 16),
                              Text('No messages yet'),
                              Text(
                                'Start the conversation!',
                                style: TextStyle(color: Color(0xFF76ABAE)), // Our accent color
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(leagueChatProvider(widget.leagueId));
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return _buildMessageBubble(message);
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(leagueChatProvider(widget.leagueId));
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: 400,
                    child: Center(child: Text('Error loading chat: $e')),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: const Border(
                top: BorderSide(color: Color(0xFF31363F)), // Our surface color
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFF76ABAE), // Our accent color
                    foregroundColor: const Color(0xFF222831), // Our dark background for contrast
                  ),
                ),
              ],
            ),
          ),
          if (!isPremium) const BannerAdSlot(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    if (message.isSystemMessage) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF31363F), // Our surface color
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              message.message,
              style: const TextStyle(
                color: Color(0xFF76ABAE), // Our accent color for system messages
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFF76ABAE), // Our accent color
            child: Text(
              message.userName[0].toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF222831), // Our dark background for contrast
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      message.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatTime(message.createdAt),
                      style: const TextStyle(
                        color: Color(0xFF76ABAE), // Our accent color
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF31363F), // Our surface color
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    message.message,
                    style: const TextStyle(
                      color: Color(0xFFEEEEEE), // Our light text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  void _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    final chatRepo = ref.read(chatRepositoryProvider);

    try {
      await chatRepo.sendMessage(
        leagueId: widget.leagueId,
        userId: currentUser.id,
        userName: currentUser.displayName,
        message: message,
      );

      _messageController.clear();

      // Refresh chat messages to show the new message
      ref.invalidate(leagueChatProvider(widget.leagueId));

      // Scroll to bottom
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to send message: $e')));
      }
    }
  }
}
