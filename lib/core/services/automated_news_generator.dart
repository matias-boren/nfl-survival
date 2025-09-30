import 'dart:async';
import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pick1/core/services/news_scraping_service.dart';
import 'package:pick1/core/services/openai_service.dart';

class AutomatedNewsGenerator {
  final SupabaseClient _supabase = Supabase.instance.client;
  final NewsScrapingService _scrapingService = NewsScrapingService();
  late final OpenAIService _openAIService;
  Timer? _timer;

  AutomatedNewsGenerator({required String openAIApiKey}) {
    _openAIService = OpenAIService(apiKey: openAIApiKey);
  }

  void startService() {
    print('Starting automated news generation service...');
    
    // Run immediately on start
    _generateNews();
    
    // Then run every 6 hours
    _timer = Timer.periodic(const Duration(hours: 6), (_) {
      _generateNews();
    });
  }

  void stopService() {
    print('Stopping automated news generation service...');
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _generateNews() async {
    try {
      print('Starting news generation cycle...');
      
      // Scrape latest news
      final scrapedArticles = await _scrapingService.scrapeLatestNews();
      print('Scraped ${scrapedArticles.length} articles');

      if (scrapedArticles.isEmpty) {
        print('No new articles found');
        return;
      }

      // Process each article
      int processedCount = 0;
      for (final article in scrapedArticles) {
        try {
          // Check if article already exists
          final exists = await _articleExists(article.url);
          if (exists) {
            print('Article already exists: ${article.title}');
            continue;
          }

          // Generate AI summary
          final summary = await _openAIService.summarizeArticle(
            title: article.title,
            content: article.content,
            source: article.source,
          );

          // Generate tags
          final tags = await _openAIService.generateTags(
            title: article.title,
            content: article.content,
          );

          // Save to database
          await _saveArticle(article, summary, tags);
          processedCount++;
          
          print('Processed article: ${article.title}');
          
          // Add delay to avoid rate limiting
          await Future.delayed(const Duration(seconds: 2));
        } catch (e) {
          print('Error processing article ${article.title}: $e');
        }
      }

      print('News generation cycle completed. Processed $processedCount new articles.');
    } catch (e) {
      print('Error in news generation cycle: $e');
    }
  }

  Future<bool> _articleExists(String url) async {
    try {
      final response = await _supabase
          .from('news_articles')
          .select('id')
          .eq('url', url)
          .maybeSingle();
      
      return response != null;
    } catch (e) {
      print('Error checking if article exists: $e');
      return false;
    }
  }

  Future<void> _saveArticle(
    NewsArticle article,
    String summary,
    List<String> tags,
  ) async {
    try {
      await _supabase.from('news_articles').insert({
        'title': article.title,
        'summary': summary,
        'content': article.content,
        'author': 'AI Reporter',
        'published_at': article.publishedAt.toIso8601String(),
        'image_url': article.imageUrl,
        'source': article.source,
        'url': article.url,
        'category': 'NFL News',
        'tags': tags,
      });
      
      print('Saved article to database: ${article.title}');
    } catch (e) {
      print('Error saving article to database: $e');
      rethrow;
    }
  }

  // Manual trigger for testing
  Future<void> generateNewsNow() async {
    await _generateNews();
  }

  // Get service status
  bool get isRunning => _timer != null;
}
