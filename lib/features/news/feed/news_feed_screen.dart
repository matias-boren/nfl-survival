import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nfl_survival/app/providers.dart';
import 'package:nfl_survival/data/news/news_repositories.dart';
import 'package:nfl_survival/data/scores/scores_repositories.dart';
import 'package:nfl_survival/data/models/nfl.dart';
import 'package:nfl_survival/data/news/mock_news_repository.dart';
import 'package:nfl_survival/data/scores/mock_scores_repository.dart';
import 'package:nfl_survival/widgets/app_scaffold.dart';
import 'package:nfl_survival/widgets/banner_ad_slot.dart';
import 'package:nfl_survival/widgets/premium_gate.dart';

class NewsFeedScreen extends ConsumerWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsFeedProvider);
    final scoresAsync = ref.watch(liveScoresProvider);
    final isPremium = ref.watch(premiumStatusProvider);

    return AppScaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(newsFeedProvider);
              ref.invalidate(liveScoresProvider);
            },
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(newsFeedProvider);
                ref.invalidate(liveScoresProvider);
              },
              child: ListView(
                children: [
                  // Live Scores Section (Premium)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PremiumGate(
                      featureName: 'Live Scores',
                      gatedChild: scoresAsync.when(
                        data: (scores) {
                          if (scores.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Live Scores',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...scores.map((score) => _buildScoreCard(context, score)),
                            ],
                          );
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (e, st) => Text('Error loading scores: $e'),
                      ),
                    ),
                  ),
                  
                  // News Articles
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Latest News',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  newsAsync.when(
                    data: (articles) {
                      if (articles.isEmpty) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.newspaper_outlined, size: 64, color: Colors.grey),
                              SizedBox(height: 16),
                              Text('No news available'),
                            ],
                          ),
                        );
                      }
                      
                      return Column(
                        children: articles.map((article) => _buildNewsCard(context, article)).toList(),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, st) => Center(child: Text('Error loading news: $e')),
                  ),
                ],
              ),
            ),
          ),
          if (!isPremium) const BannerAdSlot(),
        ],
      ),
    );
  }

  Widget _buildScoreCard(BuildContext context, LiveScore score) {
    Color statusColor = Colors.grey;
    if (score.status == 'LIVE') statusColor = Colors.red;
    if (score.status == 'FINAL') statusColor = Colors.green;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  score.status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Q${score.quarter}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    score.awayTeam.abbreviation,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  '${score.awayScore}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    score.homeTeam.abbreviation,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  '${score.homeScore}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                score.status == 'LIVE' 
                  ? 'Time: ${score.timeRemaining}'
                  : score.gameDate != null 
                    ? 'Kickoff: ${_formatGameTime(score.gameDate!.toIso8601String())}'
                    : 'Time TBD',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, NewsArticle article) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => _showArticleDetail(context, article),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      article.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (article.tags != null && article.tags!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        article.tags!.first.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                article.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.person, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    article.author ?? 'Unknown',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    _formatTime(DateTime.parse(article.publishedAt)),
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const Spacer(),
                  Text(
                    article.source,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showArticleDetail(BuildContext context, NewsArticle article) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow dismissing by tapping outside
      builder: (context) => Dialog(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with close button
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        article.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      tooltip: 'Close',
                    ),
                  ],
                ),
              ),
              // Scrollable content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image with better error handling
                      if (article.imageUrl.isNotEmpty) ...[
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: article.imageUrl,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              memCacheWidth: 400, // Cache at reasonable resolution
                              memCacheHeight: 200,
                              placeholder: (context, url) {
                                return Container(
                                  height: 200,
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) {
                                return Container(
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.image_not_supported,
                                        size: 48,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Image not available',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      // Article content
                      Text(
                        article.content,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      // Article metadata
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            Text(
                              'By ${article.author ?? 'Unknown'}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              _formatTime(DateTime.parse(article.publishedAt)),
                              style: TextStyle(color: Colors.grey[600], fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Source
                      Row(
                        children: [
                          Icon(Icons.source, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Text(
                            article.source,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      // Tags
                      if (article.tags != null && article.tags!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: article.tags!.map((tag) => Chip(
                            label: Text(
                              tag.toUpperCase(),
                              style: const TextStyle(fontSize: 10),
                            ),
                            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
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

  String _formatGameTime(String utcString) {
    try {
      final utc = DateTime.parse(utcString);
      final local = utc.toLocal();
      return '${local.month}/${local.day} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return utcString;
    }
  }
}
