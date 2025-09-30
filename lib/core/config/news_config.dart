class NewsConfig {
  // OpenAI API Key - set via dart-define in build process
  static const String openAIApiKey = String.fromEnvironment(
    'OPENAI_API_KEY',
    defaultValue: '', // Set via --dart-define=OPENAI_API_KEY=your_key
  );

  // News generation settings
  static const Duration generationInterval = Duration(hours: 6);
  static const int maxArticlesPerSource = 10;
  static const Duration articleMaxAge = Duration(hours: 6);
  
  // NFL news sources
  static const List<String> nflSources = [
    'https://www.nfl.com/news',
    'https://www.espn.com/nfl/',
    'https://www.cbssports.com/nfl/',
    'https://www.si.com/nfl',
  ];
}
