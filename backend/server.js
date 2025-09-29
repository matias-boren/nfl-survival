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
      url: process.env.REDIS_URL,
      retry_strategy: (options) => {
        if (options.error && options.error.code === 'ECONNREFUSED') {
          console.log('❌ Redis connection refused, running without cache');
          return null; // Stop retrying
        }
        if (options.total_retry_time > 1000 * 60 * 60) {
          console.log('❌ Redis retry time exhausted, running without cache');
          return null; // Stop retrying after 1 hour
        }
        if (options.attempt > 10) {
          console.log('❌ Redis max retry attempts reached, running without cache');
          return null; // Stop retrying after 10 attempts
        }
        return Math.min(options.attempt * 100, 3000); // Exponential backoff
      }
    });
    
    redisClient.on('error', (err) => {
      console.log('⚠️ Redis Client Error:', err.message);
      redisClient = null; // Disable Redis on error
    });
    
    redisClient.on('connect', () => console.log('✅ Redis connected'));
    redisClient.on('ready', () => console.log('✅ Redis ready'));
    redisClient.on('end', () => {
      console.log('⚠️ Redis connection ended');
      redisClient = null;
    });
    
    redisClient.connect().catch((error) => {
      console.log('❌ Redis connection failed:', error.message);
      redisClient = null;
    });
  } catch (error) {
    console.log('❌ Redis setup failed:', error.message);
    redisClient = null;
  }
} else {
  console.log('ℹ️ No Redis URL provided, running without cache');
}

// Middleware
app.use(helmet());
app.use(compression());
app.use(cors({
  origin: true, // Allow all origins for now
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization', 'Origin', 'X-Requested-With']
}));
app.use(express.json({ limit: '10mb' }));

// Handle preflight requests
app.options('*', (req, res) => {
  res.header('Access-Control-Allow-Origin', req.headers.origin || '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Origin, X-Requested-With');
  res.header('Access-Control-Allow-Credentials', 'true');
  res.sendStatus(200);
});

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
        
        // Cache the results only if Redis is available and connected
        if (redisClient) {
          try {
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
            console.log(`✅ Cached ${liveScores.length} games for week ${currentWeek}`);
          } catch (redisError) {
            console.log('⚠️ Redis cache error (non-critical):', redisError.message);
            // Continue without caching - this is not a critical error
          }
        } else {
          console.log('ℹ️ Redis not available, skipping cache');
        }
        
        const liveGames = liveScores.filter(score => score.isLive).length;
        if (liveGames > 0) {
          console.log(`🏈 Found ${liveGames} live games`);
        }
        
        console.log(`✅ Processed ${liveScores.length} games for week ${currentWeek}`);
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

// Parse ESPN API data
function parseESPNData(data) {
  const scores = [];
  
  if (data.events) {
    for (const event of data.events) {
      const competition = event.competitions[0];
      if (competition && competition.competitors) {
        const homeTeam = competition.competitors.find(c => c.homeAway === 'home');
        const awayTeam = competition.competitors.find(c => c.homeAway === 'away');
        
        if (homeTeam && awayTeam) {
          scores.push({
            gameId: event.id,
            homeTeam: {
              abbreviation: homeTeam.team.abbreviation,
              name: homeTeam.team.displayName
            },
            awayTeam: {
              abbreviation: awayTeam.team.abbreviation,
              name: awayTeam.team.displayName
            },
            homeScore: parseInt(homeTeam.score) || 0,
            awayScore: parseInt(awayTeam.score) || 0,
            status: event.status.type.name === 'STATUS_FINAL' ? 'FINAL' : 
                   event.status.type.name === 'STATUS_IN_PROGRESS' ? 'IN_PROGRESS' : 'SCHEDULED',
            quarter: event.status.period || '1',
            timeRemaining: event.status.displayClock || '15:00',
            isLive: event.status.type.name === 'STATUS_IN_PROGRESS',
            gameDate: event.date
          });
        }
      }
    }
  }
  
  return scores;
}

// Add CORS headers to all responses
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', req.headers.origin || '*');
  res.header('Access-Control-Allow-Credentials', 'true');
  next();
});

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
        console.log('⚠️ Redis cache get error (non-critical):', error.message);
        // Continue without cache - this is not a critical error
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
    
    // Try to fetch from ESPN API with proper headers
    console.log(`🔄 Attempting to fetch from ESPN API for week ${currentWeek}`);
    try {
      const response = await axios.get(`${ESPN_API_URL}`, {
        timeout: 10000,
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
          'Accept': 'application/json, text/plain, */*',
          'Accept-Language': 'en-US,en;q=0.9',
          'Accept-Encoding': 'gzip, deflate, br',
          'Referer': 'https://www.espn.com/',
          'Origin': 'https://www.espn.com'
        }
      });
      
      if (response.status === 200) {
        console.log(`✅ Successfully fetched from ESPN API`);
        const liveScores = parseESPNData(response.data);
        
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
            console.log(`✅ Cached live scores for week ${currentWeek}`);
          } catch (error) {
            console.log('⚠️ Redis cache set error (non-critical):', error.message);
            // Continue without caching - this is not a critical error
          }
        }
        
        return res.json({
          scores: liveScores,
          lastUpdate: Date.now(),
          week: currentWeek,
          season: currentSeason,
          source: 'espn'
        });
      }
    } catch (error) {
      console.log(`⚠️ ESPN API failed: ${error.message}, falling back to mock data`);
    }
    
    // Fallback to mock data
    console.log(`📊 Returning mock data for week ${currentWeek}`);
    const mockScores = [
      {
        gameId: 'mock-1',
        homeTeam: { abbreviation: 'KC', name: 'Kansas City Chiefs' },
        awayTeam: { abbreviation: 'BUF', name: 'Buffalo Bills' },
        homeScore: 24,
        awayScore: 21,
        status: 'FINAL',
        quarter: 'F',
        timeRemaining: '0:00',
        isLive: false,
        gameDate: new Date().toISOString()
      },
      {
        gameId: 'mock-2',
        homeTeam: { abbreviation: 'DAL', name: 'Dallas Cowboys' },
        awayTeam: { abbreviation: 'PHI', name: 'Philadelphia Eagles' },
        homeScore: 28,
        awayScore: 31,
        status: 'FINAL',
        quarter: 'F',
        timeRemaining: '0:00',
        isLive: false,
        gameDate: new Date().toISOString()
      },
      {
        gameId: 'mock-3',
        homeTeam: { abbreviation: 'GB', name: 'Green Bay Packers' },
        awayTeam: { abbreviation: 'CHI', name: 'Chicago Bears' },
        homeScore: 0,
        awayScore: 0,
        status: 'SCHEDULED',
        quarter: '1',
        timeRemaining: '15:00',
        isLive: false,
        gameDate: new Date(Date.now() + 2 * 60 * 60 * 1000).toISOString() // 2 hours from now
      }
    ];
    
    res.json({
      scores: mockScores,
      lastUpdate: Date.now(),
      week: currentWeek,
      season: currentSeason,
      source: 'mock'
    });
  } catch (error) {
    console.error('❌ Error fetching live scores:', error);
    console.log('🔄 Falling back to mock data due to error');
    
    // Fallback to mock data when any error occurs
    const mockScores = [
      {
        gameId: 'mock-1',
        homeTeam: { abbreviation: 'KC', name: 'Kansas City Chiefs' },
        awayTeam: { abbreviation: 'BUF', name: 'Buffalo Bills' },
        homeScore: 24,
        awayScore: 21,
        status: 'FINAL',
        quarter: 'F',
        timeRemaining: '0:00',
        isLive: false,
        gameDate: new Date().toISOString()
      },
      {
        gameId: 'mock-2',
        homeTeam: { abbreviation: 'DAL', name: 'Dallas Cowboys' },
        awayTeam: { abbreviation: 'PHI', name: 'Philadelphia Eagles' },
        homeScore: 28,
        awayScore: 31,
        status: 'FINAL',
        quarter: 'F',
        timeRemaining: '0:00',
        isLive: false,
        gameDate: new Date().toISOString()
      }
    ];
    
    res.json({
      scores: mockScores,
      lastUpdate: Date.now(),
      week: currentWeek,
      season: currentSeason,
      source: 'mock-error-fallback'
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
