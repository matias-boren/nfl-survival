class NewsArticle {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final String publishedAt;
  final String source;
  final String? author;
  final List<String>? tags;

  NewsArticle({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.publishedAt,
    required this.source,
    this.author,
    this.tags,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String,
      publishedAt: json['publishedAt'] as String,
      source: json['source'] as String,
      author: json['author'] as String?,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt,
      'source': source,
      'author': author,
      'tags': tags,
    };
  }
}

abstract class NewsRepository {
  Future<List<NewsArticle>> getLatestNews();
  Future<List<NewsArticle>> getNewsByTag(String tag);
  Future<NewsArticle> getArticle(String articleId);
}
