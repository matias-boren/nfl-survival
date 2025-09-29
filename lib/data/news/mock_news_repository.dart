import 'package:nfl_survival/data/news/news_repositories.dart';

class MockNewsRepository implements NewsRepository {
  @override
  Future<List<NewsArticle>> getLatestNews() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    return [
      NewsArticle(
        id: '1',
        title: 'Week 1 Power Rankings: Chiefs Lead the Pack',
        content:
            'The Kansas City Chiefs start the season as the top-ranked team in our power rankings. With Patrick Mahomes leading the offense and a strong defense, they\'re the team to beat this season. The defending champions have shown consistency in their approach, making them the favorites to repeat their success.',
        imageUrl: 'https://picsum.photos/400/200?random=1',
        publishedAt: DateTime.now()
            .subtract(const Duration(hours: 2))
            .toIso8601String(),
        source: 'NFL.com',
        author: 'John Smith',
        tags: ['power-rankings', 'chiefs', 'week-1'],
      ),
      NewsArticle(
        id: '2',
        title: 'Fantasy Football: Must-Draft Sleepers for 2025',
        content:
            'Don\'t miss out on these undervalued players who could win you your fantasy league. Our analysts break down the best late-round picks and waiver wire targets. From breakout running backs to emerging wide receivers, these sleepers could be the difference between winning and losing your league.',
        imageUrl: 'https://picsum.photos/400/200?random=2',
        publishedAt: DateTime.now()
            .subtract(const Duration(hours: 4))
            .toIso8601String(),
        source: 'ESPN',
        author: 'Jane Doe',
        tags: ['fantasy-football', 'sleepers', 'draft'],
      ),
      NewsArticle(
        id: '3',
        title: 'Injury Report: Key Players on the Mend',
        content:
            'A look at the latest injury news across the league. Good news for fans of the Green Bay Packers as their star quarterback is expected to play. Bad news for the Dallas Cowboys with a key defensive player out. These injury updates could significantly impact your survival pool picks this week.',
        imageUrl: 'https://picsum.photos/400/200?random=3',
        publishedAt: DateTime.now()
            .subtract(const Duration(hours: 6))
            .toIso8601String(),
        source: 'NFL Network',
        author: 'Mike Johnson',
        tags: ['injuries', 'packers', 'cowboys'],
      ),
      NewsArticle(
        id: '4',
        title: 'Bold Predictions for the 2025 NFL Season',
        content:
            'From surprise playoff teams to MVP dark horses, our writers make their most audacious predictions for the upcoming season. Will a new dynasty emerge? The NFL landscape is constantly changing, and this season promises to deliver unexpected twists and turns that could reshape the league hierarchy.',
        imageUrl: 'https://picsum.photos/400/200?random=4',
        publishedAt: DateTime.now()
            .subtract(const Duration(hours: 8))
            .toIso8601String(),
        source: 'The Athletic',
        author: 'Sarah Wilson',
        tags: ['predictions', 'playoffs', 'mvp'],
      ),
      NewsArticle(
        id: '5',
        title: 'Survival Pool Strategy: Week 1 Picks',
        content:
            'Expert analysis of the best teams to pick in your survival pool for Week 1. We break down the safest picks and the riskiest plays. With the season just beginning, every pick matters, and our comprehensive analysis will help you make informed decisions that could determine your pool success.',
        imageUrl: 'https://picsum.photos/400/200?random=5',
        publishedAt: DateTime.now()
            .subtract(const Duration(hours: 10))
            .toIso8601String(),
        source: 'Survival Pool Experts',
        author: 'Tom Brady',
        tags: ['survival-pool', 'strategy', 'week-1'],
      ),
    ];
  }

  @override
  Future<List<NewsArticle>> getNewsByTag(String tag) async {
    final allNews = await getLatestNews();
    return allNews
        .where((article) => article.tags?.contains(tag.toLowerCase()) ?? false)
        .toList();
  }

  @override
  Future<NewsArticle> getArticle(String articleId) async {
    final allNews = await getLatestNews();
    return allNews.firstWhere((article) => article.id == articleId);
  }
}
