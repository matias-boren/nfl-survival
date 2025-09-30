# News Generation Service

This service automatically scrapes NFL news from multiple sources every 6 hours and uses OpenAI to generate summaries and tags.

## Setup

1. **Get OpenAI API Key**
   - Go to https://platform.openai.com/api-keys
   - Create a new API key
   - Set it as an environment variable: `OPENAI_API_KEY=your_key_here`

2. **Create News Articles Table**
   - Run the SQL script: `create_news_articles_table.sql`
   - This creates the `news_articles` table in Supabase

3. **Configure Environment**
   - Set the `OPENAI_API_KEY` environment variable
   - The service will automatically start if the key is found

## Features

- **Automated Scraping**: Runs every 6 hours
- **Multiple Sources**: NFL.com, ESPN, CBS Sports, Sports Illustrated
- **AI Summarization**: Uses OpenAI GPT-3.5-turbo to create engaging summaries
- **Smart Filtering**: Only includes articles from the last 6 hours
- **Duplicate Prevention**: Checks for existing articles before adding
- **Admin Interface**: Manual trigger and monitoring at `/admin/news-management`

## News Sources

- https://www.nfl.com/news
- https://www.espn.com/nfl/
- https://www.cbssports.com/nfl/
- https://www.si.com/nfl

## Admin Interface

Visit `/admin/news-management` to:
- View service status
- Manually trigger news generation
- Monitor recent articles
- Refresh the news feed

## Configuration

Edit `lib/core/config/news_config.dart` to modify:
- Generation interval (default: 6 hours)
- Maximum articles per source (default: 10)
- Article maximum age (default: 6 hours)
- News sources list

## Troubleshooting

1. **No articles appearing**: Check if OpenAI API key is set
2. **Service not starting**: Verify environment variables
3. **Scraping errors**: Check network connectivity and source availability
4. **Database errors**: Ensure `news_articles` table exists and has proper permissions
