import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey;
  final String baseUrl = 'https://api.openai.com/v1';

  OpenAIService({required this.apiKey});

  Future<String> summarizeArticle({
    required String title,
    required String content,
    required String source,
  }) async {
    try {
      final prompt = _buildSummarizationPrompt(title, content, source);
      
      final response = await http.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content': 'You are a sports journalist specializing in NFL news. Create engaging, concise summaries of NFL articles that would be valuable for survival pool participants. Focus on key insights, player updates, and strategic implications.',
            },
            {
              'role': 'user',
              'content': prompt,
            }
          ],
          'max_tokens': 300,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('OpenAI API error: ${response.statusCode} - ${response.body}');
      }

      final responseData = jsonDecode(response.body);
      final summary = responseData['choices'][0]['message']['content'] as String;
      
      return summary.trim();
    } catch (e) {
      print('Error calling OpenAI API: $e');
      // Fallback to a simple truncation if OpenAI fails
      return _createFallbackSummary(content);
    }
  }

  Future<List<String>> generateTags({
    required String title,
    required String content,
  }) async {
    try {
      final prompt = '''
Analyze this NFL article and generate 3-5 relevant tags that would help categorize it for a survival pool app.

Title: $title
Content: ${content.substring(0, content.length > 500 ? 500 : content.length)}...

Generate tags like: team-names, injury-report, power-rankings, trade-news, etc.
Return only the tags, one per line, no other text.
''';

      final response = await http.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'user',
              'content': prompt,
            }
          ],
          'max_tokens': 100,
          'temperature': 0.3,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('OpenAI API error: ${response.statusCode} - ${response.body}');
      }

      final responseData = jsonDecode(response.body);
      final tagsText = responseData['choices'][0]['message']['content'] as String;
      
      return tagsText
          .split('\n')
          .map((tag) => tag.trim().toLowerCase().replaceAll(' ', '-'))
          .where((tag) => tag.isNotEmpty)
          .toList();
    } catch (e) {
      print('Error generating tags with OpenAI: $e');
      // Fallback to basic tags
      return ['nfl', 'news', 'football'];
    }
  }

  String _buildSummarizationPrompt(String title, String content, String source) {
    return '''
Please summarize this NFL article for a survival pool app audience. Focus on information that would help users make better picks.

Title: $title
Source: $source
Content: ${content.length > 1000 ? content.substring(0, 1000) + '...' : content}

Create a concise summary (2-3 sentences) that highlights:
- Key player updates or injuries
- Team performance insights
- Strategic implications for survival pool picks
- Any breaking news or important developments

Keep it engaging and informative for NFL fans participating in survival pools.
''';
  }

  String _createFallbackSummary(String content) {
    // Simple fallback: take the first 200 characters and add ellipsis
    if (content.length <= 200) return content;
    return '${content.substring(0, 200)}...';
  }
}
