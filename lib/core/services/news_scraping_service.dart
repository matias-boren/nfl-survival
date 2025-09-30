import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;

class NewsArticle {
  final String title;
  final String content;
  final String url;
  final String source;
  final DateTime publishedAt;
  final String? imageUrl;

  NewsArticle({
    required this.title,
    required this.content,
    required this.url,
    required this.source,
    required this.publishedAt,
    this.imageUrl,
  });
}

class NewsScrapingService {
  static const List<String> nflSources = [
    'https://www.nfl.com/news',
    'https://www.espn.com/nfl/',
    'https://www.cbssports.com/nfl/',
    'https://www.si.com/nfl',
  ];

  static const Map<String, Map<String, String>> sourceSelectors = {
    'nfl.com': {
      'articleSelector': '.nfl-c-article__content',
      'titleSelector': 'h1, .nfl-c-article__title',
      'contentSelector': '.nfl-c-article__body p',
      'linkSelector': 'a[href*="/news/"]',
    },
    'espn.com': {
      'articleSelector': '.contentItem__content',
      'titleSelector': 'h1, .contentItem__title',
      'contentSelector': '.article-body p',
      'linkSelector': 'a[href*="/nfl/"]',
    },
    'cbssports.com': {
      'articleSelector': '.ArticleBody',
      'titleSelector': 'h1, .ArticleTitle',
      'contentSelector': '.ArticleBody p',
      'linkSelector': 'a[href*="/nfl/"]',
    },
    'si.com': {
      'articleSelector': '.article-content',
      'titleSelector': 'h1, .article-title',
      'contentSelector': '.article-content p',
      'linkSelector': 'a[href*="/nfl/"]',
    },
  };

  Future<List<NewsArticle>> scrapeLatestNews() async {
    final List<NewsArticle> allArticles = [];
    
    for (final source in nflSources) {
      try {
        print('Scraping news from: $source');
        final articles = await _scrapeSource(source);
        allArticles.addAll(articles);
        print('Found ${articles.length} articles from $source');
      } catch (e) {
        print('Error scraping $source: $e');
      }
    }

    // Filter articles to only include those from the last 6 hours
    final sixHoursAgo = DateTime.now().subtract(const Duration(hours: 6));
    final recentArticles = allArticles
        .where((article) => article.publishedAt.isAfter(sixHoursAgo))
        .toList();

    // Sort by publication date (newest first)
    recentArticles.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

    print('Total recent articles found: ${recentArticles.length}');
    return recentArticles;
  }

  Future<List<NewsArticle>> _scrapeSource(String baseUrl) async {
    final client = http.Client();
    try {
      final response = await client.get(
        Uri.parse(baseUrl),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch $baseUrl: ${response.statusCode}');
      }

      final document = html_parser.parse(response.body);
      final domain = _extractDomain(baseUrl);
      final selectors = sourceSelectors[domain] ?? sourceSelectors['nfl.com']!;

      final articles = <NewsArticle>[];
      
      // Find article links
      final articleLinks = document.querySelectorAll(selectors['linkSelector']!);
      
      for (final link in articleLinks.take(10)) { // Limit to 10 articles per source
        final href = link.attributes['href'];
        if (href == null) continue;

        final articleUrl = _resolveUrl(baseUrl, href);
        try {
          final article = await _scrapeArticle(articleUrl, selectors);
          if (article != null) {
            articles.add(article);
          }
        } catch (e) {
          print('Error scraping article $articleUrl: $e');
        }
      }

      return articles;
    } finally {
      client.close();
    }
  }

  Future<NewsArticle?> _scrapeArticle(String url, Map<String, String> selectors) async {
    final client = http.Client();
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        },
      );

      if (response.statusCode != 200) {
        return null;
      }

      final document = html_parser.parse(response.body);
      
      // Extract title
      final titleElement = document.querySelector(selectors['titleSelector']!);
      if (titleElement == null) return null;
      final title = titleElement.text.trim();
      if (title.isEmpty) return null;

      // Extract content
      final contentElements = document.querySelectorAll(selectors['contentSelector']!);
      final content = contentElements
          .map((e) => e.text.trim())
          .where((text) => text.isNotEmpty)
          .join('\n\n');

      if (content.isEmpty) return null;

      // Extract image URL
      final imageElement = document.querySelector('img');
      final imageUrl = imageElement?.attributes['src'];

      // Extract publication date (try multiple selectors)
      DateTime publishedAt = DateTime.now();
      final dateSelectors = [
        'time[datetime]',
        '.published-date',
        '.article-date',
        '[data-published]',
      ];

      for (final selector in dateSelectors) {
        final dateElement = document.querySelector(selector);
        if (dateElement != null) {
          final dateString = dateElement.attributes['datetime'] ?? 
                           dateElement.attributes['data-published'] ??
                           dateElement.text.trim();
          try {
            publishedAt = DateTime.parse(dateString);
            break;
          } catch (e) {
            // Try parsing relative dates
            if (dateString.contains('ago')) {
              publishedAt = _parseRelativeDate(dateString);
              break;
            }
          }
        }
      }

      return NewsArticle(
        title: title,
        content: content,
        url: url,
        source: _extractDomain(url),
        publishedAt: publishedAt,
        imageUrl: imageUrl,
      );
    } finally {
      client.close();
    }
  }

  String _extractDomain(String url) {
    final uri = Uri.parse(url);
    final host = uri.host.toLowerCase();
    if (host.contains('nfl.com')) return 'nfl.com';
    if (host.contains('espn.com')) return 'espn.com';
    if (host.contains('cbssports.com')) return 'cbssports.com';
    if (host.contains('si.com')) return 'si.com';
    return host;
  }

  String _resolveUrl(String baseUrl, String href) {
    if (href.startsWith('http')) return href;
    if (href.startsWith('//')) return 'https:$href';
    if (href.startsWith('/')) {
      final baseUri = Uri.parse(baseUrl);
      return '${baseUri.scheme}://${baseUri.host}$href';
    }
    return '$baseUrl/$href';
  }

  DateTime _parseRelativeDate(String dateString) {
    final now = DateTime.now();
    if (dateString.contains('minute')) {
      final minutes = int.tryParse(dateString.split(' ')[0]) ?? 0;
      return now.subtract(Duration(minutes: minutes));
    } else if (dateString.contains('hour')) {
      final hours = int.tryParse(dateString.split(' ')[0]) ?? 0;
      return now.subtract(Duration(hours: hours));
    } else if (dateString.contains('day')) {
      final days = int.tryParse(dateString.split(' ')[0]) ?? 0;
      return now.subtract(Duration(days: days));
    }
    return now;
  }
}
