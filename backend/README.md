# NFL Survival Backend

This is the backend server for the NFL Survival Pool app, providing API endpoints for live scores, news generation, and other services.

## Features

- **Live Scores API**: Fetches real-time NFL scores from ESPN API
- **AI News Generation**: Automatically generates AI-powered NFL news every 6 hours
- **News Scraping**: Scrapes news from multiple NFL sources
- **Caching**: Uses Redis for caching API responses
- **Rate Limiting**: Implements rate limiting for API endpoints

## Environment Variables

Create a `.env` file in the backend directory with the following variables:

```env
# Server Configuration
PORT=3000
NODE_ENV=production

# Supabase Configuration
SUPABASE_URL=your_supabase_url
SUPABASE_SERVICE_KEY=your_supabase_service_key

# OpenAI Configuration
OPENAI_API_KEY=your_openai_api_key

# Redis Configuration (optional)
REDIS_URL=your_redis_url
REDIS_HOST=localhost
REDIS_PORT=6379

# ESPN API Configuration
ESPN_API_BASE_URL=https://site.api.espn.com/apis/site/v2/sports/football/nfl
```

## Setup

1. Install dependencies:
```bash
npm install
```

2. Set up environment variables (see above)

3. Run the database migration:
```sql
-- Run this in your Supabase SQL editor
-- (See create_news_articles_table.sql)
```

4. Start the server:
```bash
npm start
```

## API Endpoints

### Live Scores
- `GET /api/live-scores?week=4&season=2025` - Get live scores for a specific week

### Health Check
- `GET /api/health` - Check server health

### Admin (Manual News Generation)
- `POST /api/admin/generate-news` - Manually trigger news generation

## Scheduled Tasks

- **News Generation**: Runs every 6 hours (0 */6 * * *)
- **ESPN Polling**: Continuously polls ESPN API for live scores

## News Sources

The system scrapes news from:
- NFL.com
- ESPN NFL
- CBS Sports NFL

## AI News Generation

The system uses OpenAI's GPT-3.5-turbo to:
1. Scrape recent NFL news (less than 6 hours old)
2. Generate AI summaries for each article
3. Store articles in Supabase database
4. Avoid duplicate articles

## Deployment

The backend is designed to run on Railway, Vercel, or any Node.js hosting platform.

### Railway Deployment
1. Connect your GitHub repository to Railway
2. Set environment variables in Railway dashboard
3. Deploy automatically on push to main branch

### Manual Deployment
1. Build the application: `npm run build`
2. Start the server: `npm start`
3. Ensure all environment variables are set
