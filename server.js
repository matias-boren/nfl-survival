const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const compression = require('compression');
const rateLimit = require('express-rate-limit');
const { body, validationResult } = require('express-validator');
const cron = require('node-cron');
const axios = require('axios');
const redis = require('redis');

// Load environment variables
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Redis client (optional)
let redisClient = null;

// Only try to connect to Redis if REDIS_URL is provided
if (process.env.REDIS_URL) {
  try {
    redisClient = redis.createClient({
      url: process.env.REDIS_URL
    });
    redisClient.on('error', (err) => console.log('Redis Client Error:', err.message));
    redisClient.on('connect', () => console.log('✅ Redis connected'));
    redisClient.connect();
  } catch (error) {
    console.log('❌ Redis connection failed:', error.message);
    redisClient = null;
  }
} else {
  console.log('ℹ️ No Redis URL provided, running without cache');
}

// Middleware
app.use(helmet());
app.use(compression());
app.use(cors({
  origin: [
    'https://nfl-survival.netlify.app',
    'http://localhost:3000',
    'http://localhost:8080'
  ],
  credentials: true
}));
app.use(express.json({ limit: '10mb' }));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP, please try again later.'
});
app.use('/api/', limiter);

// Cache configuration
const CACHE_DURATION = 15; // seconds
const ESPN_API_URL = 'https://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard';

// ESPN API polling service
class ESPNPollingService {
  constructor() {
    this.isPolling = false;
    this.pollingInterval = null;
  }

  startPolling() {
    if (this.isPolling) return;
    
    console.log('🚀 Starting ESPN API polling service...');
    this.isPolling = true;
    
    // Poll immediately
    this.pollESPN();
    
    // Then poll every 15 seconds
    this.pollingInterval = setInterval(() => {
      this.pollESPN();
    }, 15000);
  }

  stopPolling() {
    if (this.pollingInterval) {
      clearInterval(this.pollingInterval);
      this.pollingInterval = null;
    }
    this.isPolling = false;
    console.log('🛑 Stopped ESPN API polling service');
  }

  async pollESPN() {
    try {
      console.log('📡 Polling ESPN API...');
      
      const currentWeek = this.getCurrentWeek();
      const season = 2025;
      
      const response = await axios.get(`${ESPN_API_URL}?week=${currentWeek}&season=${season}`, {
        timeout: 10000,
        headers: {
          'User-Agent': 'NFL-Survival-App/1.0'
        }
      });
      
      if (response.status === 200) {
        const data = response.data;
        const liveScores = this.parseESPNData(data);
        
        // Cache the results
        await redisClient.setEx(
          `live-scores:week-${currentWeek}`,
          CACHE_DURATION,
          JSON.stringify({
            scores: liveScores,
            lastUpdate: Date.now(),
            week: currentWeek,
            season: season
          })
        );
        
        const liveGames = liveScores.filter(score => score.isLive).length;
        if (liveGames > 0) {
          console.log(`🏈 Found ${liveGames} live games`);
        }
        
        console.log(`✅ Cached ${liveScores.length} games for week ${currentWeek}`);
      } else {
        console.log('❌ ESPN API request failed:', response.status);
      }
    } catch (error) {
      if (error.response) {
        console.error('💥 Error polling ESPN API:', error.response.status, error.response.statusText);
        console.error('Response data:', error.response.data);
      } else {
        console.error('💥 Error polling ESPN API:', error.message);
      }
    }
  }

  parseESPNData(data) {
    const scores = [];
    
    if (data.events) {
      for (const event of data.events) {
        const competition = event.competitions[0];
        const competitors = competition.competitors;
        
        // Determine home and away teams
        const homeTeam = competitors.find(c => c.homeAway === 'home');
        const awayTeam = competitors.find(c => c.homeAway === 'away');
        
        if (homeTeam && awayTeam) {
          scores.push({
            gameId: event.id,
            homeTeam: {
              id: homeTeam.team.id,
              name: homeTeam.team.displayName,
              abbreviation: homeTeam.team.abbreviation,
              city: homeTeam.team.name,
              logoUrl: homeTeam.team.logo,
              color: homeTeam.team.color,
              alternateColor: homeTeam.team.alternateColor,
            },
            awayTeam: {
              id: awayTeam.team.id,
              name: awayTeam.team.displayName,
              abbreviation: awayTeam.team.abbreviation,
              city: awayTeam.team.name,
              logoUrl: awayTeam.team.logo,
              color: awayTeam.team.color,
              alternateColor: awayTeam.team.alternateColor,
            },
            homeScore: homeTeam.score || 0,
            awayScore: awayTeam.score || 0,
            status: event.status.type.name,
            quarter: competition.status.period || 0,
            timeRemaining: competition.status.displayClock || '15:00',
            isLive: event.status.type.name === 'STATUS_IN_PROGRESS',
            gameDate: event.date,
          });
        }
      }
    }
    
    return scores;
  }

  getCurrentWeek() {
    // Simple week calculation - in production, use a more sophisticated method
    const now = new Date();
    const seasonStart = new Date('2025-09-01'); // NFL season start
    const weeksSinceStart = Math.floor((now - seasonStart) / (7 * 24 * 60 * 60 * 1000));
    return Math.max(1, Math.min(18, weeksSinceStart + 1));
  }
}

// Initialize ESPN polling service
const espnService = new ESPNPollingService();

// API Routes
app.get('/', (req, res) => {
  res.json({
    message: 'NFL Survival Backend API',
    status: 'running',
    timestamp: new Date().toISOString()
  });
});

app.get('/api/health', (req, res) => {
  console.log('🏥 Health check requested');
  try {
    const healthData = {
      status: 'healthy',
      timestamp: new Date().toISOString(),
      uptime: process.uptime(),
      port: PORT,
      memory: process.memoryUsage(),
      nodeVersion: process.version,
      redis: redisClient ? 'available' : 'not configured'
    };
    console.log('✅ Health check passed:', healthData);
    res.json(healthData);
  } catch (error) {
    console.error('❌ Health check failed:', error);
    res.status(500).json({
      status: 'unhealthy',
      error: error.message
    });
  }
});

app.get('/api/live-scores', async (req, res) => {
  try {
    const { week, season } = req.query;
    const currentWeek = week || espnService.getCurrentWeek();
    const currentSeason = season || 2025;
    
    console.log(`📊 Live scores request: week=${currentWeek}, season=${currentSeason}`);
    console.log(`📊 Request from: ${req.get('origin') || 'unknown'}`);
    
    // Try to get from cache first (if Redis is available)
    const cacheKey = `live-scores:week-${currentWeek}`;
    let cachedData = null;
    if (redisClient) {
      try {
        cachedData = await redisClient.get(cacheKey);
      } catch (error) {
        console.log('Redis cache error:', error.message);
      }
    }
    
    if (cachedData) {
      console.log(`📦 Serving cached live scores for week ${currentWeek}`);
      const data = JSON.parse(cachedData);
      return res.json({
        ...data,
        cached: true,
        source: 'cache'
      });
    }
    
    // If no cache, fetch from ESPN
    console.log(`🔄 No cache found, fetching from ESPN for week ${currentWeek}`);
    const response = await axios.get(`${ESPN_API_URL}?week=${currentWeek}&season=${currentSeason}`, {
      timeout: 10000,
      headers: {
        'User-Agent': 'NFL-Survival-App/1.0'
      }
    });
    
    if (response.status === 200) {
      const liveScores = espnService.parseESPNData(response.data);
      
      // Cache the results (if Redis is available)
      if (redisClient) {
        try {
          await redisClient.setEx(
            cacheKey,
            CACHE_DURATION,
            JSON.stringify({
              scores: liveScores,
              lastUpdate: Date.now(),
              week: currentWeek,
              season: currentSeason
            })
          );
        } catch (error) {
          console.log('Redis cache set error:', error.message);
        }
      }
      
      res.json({
        scores: liveScores,
        lastUpdate: Date.now(),
        week: currentWeek,
        season: currentSeason,
        source: 'espn'
      });
    } else {
      res.status(500).json({
        error: 'Failed to fetch from ESPN API',
        status: response.status
      });
    }
  } catch (error) {
    console.error('❌ Error fetching live scores:', error);
    res.status(500).json({
      error: 'Internal server error',
      message: error.message
    });
  }
});

// Global error handler
process.on('uncaughtException', (error) => {
  console.error('❌ Uncaught Exception:', error);
  process.exit(1);
});

process.on('unhandledRejection', (reason, promise) => {
  console.error('❌ Unhandled Rejection at:', promise, 'reason:', reason);
  process.exit(1);
});

// Start the server
try {
  app.listen(PORT, '0.0.0.0', () => {
    console.log(`🚀 Server running on port ${PORT}`);
    console.log(`🌐 Environment: ${process.env.NODE_ENV || 'development'}`);
    console.log(`🔗 Health check available at: http://0.0.0.0:${PORT}/api/health`);
    console.log(`📊 Redis status: ${redisClient ? 'Connected' : 'Not configured'}`);
    
    // Start ESPN polling
    espnService.startPolling();
    console.log('✅ ESPN polling enabled - fetching real NFL data');
  });
} catch (error) {
  console.error('❌ Failed to start server:', error);
  process.exit(1);
}

// Graceful shutdown
process.on('SIGINT', () => {
  console.log('🛑 Shutting down server...');
  espnService.stopPolling();
  if (redisClient) {
    redisClient.quit();
  }
  process.exit(0);
});

process.on('SIGTERM', () => {
  console.log('🛑 Shutting down server...');
  espnService.stopPolling();
  if (redisClient) {
    redisClient.quit();
  }
  process.exit(0);
});

module.exports = app;
