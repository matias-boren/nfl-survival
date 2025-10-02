const express = require('express');
const cron = require('node-cron');
const { createClient } = require('@supabase/supabase-js');
const OpenAI = require('openai');
const NewsScrapingService = require('./services/newsScrapingService');
const NewsProcessingService = require('./services/newsProcessingService');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

// Initialize services
const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

const newsScrapingService = new NewsScrapingService();
const newsProcessingService = new NewsProcessingService(supabase, openai);

// Middleware
app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ 
    status: 'healthy', 
    service: 'pick1-news-service',
    timestamp: new Date().toISOString(),
    version: '1.0.0'
  });
});

// Manual news generation endpoint (for testing)
app.post('/generate-news', async (req, res) => {
  try {
    console.log('🔄 Manual news generation triggered');
    const result = await generateNews();
    res.json({
      success: true,
      message: 'News generation completed',
      ...result
    });
  } catch (error) {
    console.error('❌ Error in manual news generation:', error);
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
});

// Get service status
app.get('/status', (req, res) => {
  res.json({
    service: 'pick1-news-service',
    status: 'running',
    nextScheduledRun: getNextCronRun(),
    environment: {
      supabaseConfigured: !!process.env.SUPABASE_URL,
      openaiConfigured: !!process.env.OPENAI_API_KEY,
    }
  });
});

// Main news generation function
async function generateNews() {
  const startTime = Date.now();
  console.log('📰 Starting automated news generation cycle...');
  
  try {
    // Step 1: Scrape latest news
    console.log('🔍 Scraping latest NFL news...');
    const scrapedArticles = await newsScrapingService.scrapeLatestNews();
    console.log(`📄 Found ${scrapedArticles.length} articles to process`);

    if (scrapedArticles.length === 0) {
      console.log('ℹ️ No new articles found');
      return {
        articlesFound: 0,
        articlesProcessed: 0,
        duration: Date.now() - startTime
      };
    }

    // Step 2: Process articles with AI
    console.log('🤖 Processing articles with OpenAI...');
    const result = await newsProcessingService.processArticles(scrapedArticles);
    
    const duration = Date.now() - startTime;
    console.log(`✅ News generation completed in ${duration}ms`);
    console.log(`📊 Processed ${result.processed}/${result.total} articles`);
    
    return {
      articlesFound: scrapedArticles.length,
      articlesProcessed: result.processed,
      articlesSkipped: result.skipped,
      errors: result.errors,
      duration
    };
  } catch (error) {
    console.error('❌ Error in news generation cycle:', error);
    throw error;
  }
}

// Helper function to get next cron run time
function getNextCronRun() {
  // Cron runs every 6 hours: 0 */6 * * *
  const now = new Date();
  const nextRun = new Date(now);
  const currentHour = now.getHours();
  
  // Find next 6-hour interval (0, 6, 12, 18)
  const nextHour = Math.ceil((currentHour + 1) / 6) * 6;
  nextRun.setHours(nextHour % 24, 0, 0, 0);
  
  // If we've passed 18:00 today, next run is tomorrow at 00:00
  if (nextHour >= 24) {
    nextRun.setDate(nextRun.getDate() + 1);
  }
  
  return nextRun.toISOString();
}

// Schedule automated news generation every 6 hours
// Runs at: 00:00, 06:00, 12:00, 18:00 UTC
cron.schedule('0 */6 * * *', async () => {
  console.log('⏰ Scheduled news generation triggered');
  try {
    await generateNews();
  } catch (error) {
    console.error('❌ Scheduled news generation failed:', error);
  }
}, {
  scheduled: true,
  timezone: "UTC"
});

// Start server
app.listen(port, () => {
  console.log(`🚀 Pick1 News Service running on port ${port}`);
  console.log(`📅 Next scheduled run: ${getNextCronRun()}`);
  console.log('🔄 Service ready for automated news generation');
  
  // Run initial news generation on startup (optional)
  if (process.env.RUN_ON_STARTUP === 'true') {
    setTimeout(() => {
      console.log('🎬 Running initial news generation...');
      generateNews().catch(console.error);
    }, 5000); // Wait 5 seconds for service to fully initialize
  }
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('🛑 Received SIGTERM, shutting down gracefully');
  process.exit(0);
});

process.on('SIGINT', () => {
  console.log('🛑 Received SIGINT, shutting down gracefully');
  process.exit(0);
});
