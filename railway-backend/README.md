# Pick1 News Service

Automated news generation service for the Pick1 NFL Survival app. This service runs on Railway and automatically scrapes NFL news, processes it with OpenAI, and stores it in Supabase.

## Features

- 🔄 **Automated News Generation** - Runs every 6 hours (00:00, 06:00, 12:00, 18:00 UTC)
- 🤖 **AI-Powered Summaries** - Uses OpenAI GPT-3.5 to create engaging summaries
- 🏷️ **Smart Tagging** - Automatically generates relevant tags for articles
- 📰 **Multi-Source Scraping** - Scrapes from ESPN, NFL.com, CBS Sports
- 🚫 **Duplicate Prevention** - Avoids processing the same article twice
- 📊 **Health Monitoring** - Health check and status endpoints

## API Endpoints

### Health Check
```
GET /health
```
Returns service health status.

### Manual News Generation
```
POST /generate-news
```
Triggers manual news generation (for testing).

### Service Status
```
GET /status
```
Returns service status and next scheduled run time.

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `SUPABASE_URL` | Your Supabase project URL | Yes |
| `SUPABASE_ANON_KEY` | Your Supabase anon key | Yes |
| `OPENAI_API_KEY` | Your OpenAI API key | Yes |
| `PORT` | Server port (default: 3000) | No |
| `RUN_ON_STARTUP` | Run news generation on startup | No |
| `NODE_ENV` | Environment (production/development) | No |

## Deployment on Railway

1. **Create Railway Project**
   ```bash
   railway new pick1-news-service
   ```

2. **Set Environment Variables**
   ```bash
   railway variables set SUPABASE_URL=your_url
   railway variables set SUPABASE_ANON_KEY=your_key
   railway variables set OPENAI_API_KEY=your_openai_key
   ```

3. **Deploy**
   ```bash
   railway up
   ```

## Local Development

1. **Install Dependencies**
   ```bash
   npm install
   ```

2. **Set Environment Variables**
   ```bash
   cp env.example .env
   # Edit .env with your values
   ```

3. **Run Development Server**
   ```bash
   npm run dev
   ```

## How It Works

1. **Scheduled Execution** - Cron job runs every 6 hours
2. **News Scraping** - Scrapes latest articles from NFL news sources
3. **AI Processing** - Uses OpenAI to generate summaries and tags
4. **Database Storage** - Saves processed articles to Supabase
5. **Duplicate Prevention** - Checks existing articles to avoid duplicates

## Monitoring

- **Health Check**: `GET /health` - Basic service health
- **Status Check**: `GET /status` - Detailed service status
- **Logs**: Railway provides comprehensive logging
- **Manual Trigger**: `POST /generate-news` for testing

## News Sources

- ESPN NFL News
- NFL.com Official News
- CBS Sports NFL
- (More sources can be added easily)

## Database Schema

The service expects a `news_articles` table in Supabase with these columns:
- `id` (uuid, primary key)
- `title` (text)
- `summary` (text)
- `content` (text)
- `author` (text)
- `published_at` (timestamp)
- `image_url` (text)
- `source` (text)
- `url` (text, unique)
- `category` (text)
- `tags` (text array)

## Error Handling

- Graceful handling of scraping failures
- OpenAI API rate limiting protection
- Database connection error recovery
- Individual article processing isolation
