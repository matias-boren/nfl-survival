import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pick1/data/news/news_repositories.dart';

class SupabaseNewsRepository implements NewsRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<List<NewsArticle>> getLatestNews() async {
    try {
      final response = await _supabase
          .from('news_articles')
          .select()
          .order('published_at', ascending: false)
          .limit(20);

      return response.map((row) => _newsArticleFromSupabase(row)).toList();
    } catch (e) {
      print('Error fetching latest news: $e');
      return [];
    }
  }

  @override
  Future<NewsArticle> getArticle(String articleId) async {
    try {
      final response = await _supabase
          .from('news_articles')
          .select()
          .eq('id', articleId)
          .single();

      return _newsArticleFromSupabase(response);
    } catch (e) {
      print('Error fetching news article: $e');
      rethrow;
    }
  }

  @override
  Future<List<NewsArticle>> getNewsByTag(String tag) async {
    try {
      final response = await _supabase
          .from('news_articles')
          .select()
          .contains('tags', [tag])
          .order('published_at', ascending: false)
          .limit(20);

      return response.map((row) => _newsArticleFromSupabase(row)).toList();
    } catch (e) {
      print('Error fetching news by tag: $e');
      return [];
    }
  }

  NewsArticle _newsArticleFromSupabase(Map<String, dynamic> data) {
    return NewsArticle(
      id: data['id'],
      title: data['title'],
      content: data['content'],
      imageUrl: data['image_url'] ?? '',
      publishedAt: DateTime.parse(data['published_at']).toIso8601String(),
      source: data['source'] ?? 'NFL News',
      author: data['author'],
      tags: List<String>.from(data['tags'] ?? ['NFL', 'News']),
    );
  }
}
