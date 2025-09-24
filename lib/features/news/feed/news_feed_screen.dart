import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';
import 'package:nfl_survival/widgets/banner_ad_slot.dart';
import 'package:nfl_survival/widgets/premium_gate.dart';

class NewsArticle {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String publishedAt;
  final String author;

  NewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.publishedAt,
    required this.author,
  });
}

final newsProvider = FutureProvider<List<NewsArticle>>((ref) async {
  // Mock news data - in real app, this would come from an API
  await Future.delayed(const Duration(milliseconds: 500));
  return [
    NewsArticle(
      id: 'news_1',
      title: 'Week 1 Preview: Top Picks for Your Survival Pool',
      summary: 'Expert analysis of the safest picks for Week 1 of the NFL season.',
      content: 'With the NFL season kicking off, survival pool participants need to make their first crucial pick...',
      publishedAt: '2025-09-01T10:00:00Z',
      author: 'NFL Analysis Team',
    ),
    NewsArticle(
      id: 'news_2',
      title: 'Injury Report: Key Players to Watch',
      summary: 'Latest injury updates that could impact your survival pool strategy.',
      content: 'Several key players are questionable for Week 1. Monitor these injury reports closely...',
      publishedAt: '2025-09-02T14:30:00Z',
      author: 'Injury Report Team',
    ),
    NewsArticle(
      id: 'news_3',
      title: 'Survival Pool Strategy: Week 1 Dos and Don\'ts',
      summary: 'Essential tips for making your first survival pool pick of the season.',
      content: 'Week 1 presents unique challenges for survival pool participants...',
      publishedAt: '2025-09-03T09:15:00Z',
      author: 'Strategy Team',
    ),
  ];
});

class NewsFeedScreen extends ConsumerWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsProvider);
    final isPremium = ref.watch(premiumStatusProvider).valueOrNull ?? false;

    return AppScaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(newsProvider);
            },
          ),
        ],
      ),
      child: Column(
        children: [
          // Live Scores Section (Premium Feature)
          PremiumGate(
            featureName: 'Live Scores',
            gatedChild: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.sports_football, color: Colors.green.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'Live Scores',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildLiveScoreRow('KC', 'BUF', 24, 17, 'Q4 2:34'),
                  _buildLiveScoreRow('DAL', 'PHI', 14, 10, 'Q2 8:45'),
                  _buildLiveScoreRow('SF', 'LAR', 21, 21, 'Q3 12:15'),
                ],
              ),
            ),
          ),
          // News Articles
          Expanded(
            child: newsAsync.when(
              data: (articles) {
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        title: Text(
                          article.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(article.summary),
                            const SizedBox(height: 4),
                            Text(
                              'By ${article.author} • ${_formatDate(article.publishedAt)}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        onTap: () {
                          _showArticleDetail(context, article);
                        },
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
          if (!isPremium) const BannerAdSlot(),
        ],
      ),
    );
  }

  Widget _buildLiveScoreRow(String home, String away, int homeScore, int awayScore, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '$home $homeScore - $awayScore $away',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showArticleDetail(BuildContext context, NewsArticle article) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(article.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'By ${article.author} • ${_formatDate(article.publishedAt)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),
              Text(article.content),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _formatDate(String isoString) {
    final date = DateTime.parse(isoString);
    return '${date.month}/${date.day}/${date.year}';
  }
}
