class NewsConfig {
  // OpenAI API Key - should be set from environment variables
  static const String openAIApiKey = String.fromEnvironment(
    'OPENAI_API_KEY',
    defaultValue: '', // Will be set from .env file
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
