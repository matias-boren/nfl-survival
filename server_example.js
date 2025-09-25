// Example Node.js/Express backend server
// This would run on your server and poll ESPN API once, then serve to all clients

const express = require('express');
const http = require('http');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// In-memory cache (in production, use Redis or database)
let liveScoresCache = [];
let lastUpdateTime = null;
const CACHE_DURATION = 15000; // 15 seconds

// ESPN API polling service
class ESPNPollingService {
  constructor() {
    this.isPolling = false;
    this.pollingInterval = null;
  }

  startPolling() {
    if (this.isPolling) return;
    
    console.log('Starting ESPN API polling...');
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
    console.log('Stopped ESPN API polling');
  }

  async pollESPN() {
    try {
      console.log('Polling ESPN API...');
      
      // Get current week (you'd implement this logic)
      const currentWeek = this.getCurrentWeek();
      const season = 2025;
      
      const response = await fetch(`https://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard?week=${currentWeek}&season=${season}`);
      
      if (response.ok) {
        const data = await response.json();
        liveScoresCache = this.parseESPNData(data);
        lastUpdateTime = Date.now();
        
        const liveGames = liveScoresCache.filter(score => score.isLive).length;
        if (liveGames > 0) {
          console.log(`Found ${liveGames} live games`);
        }
      } else {
        console.log('ESPN API request failed:', response.status);
      }
    } catch (error) {
      console.error('Error polling ESPN API:', error);
    }
  }

  parseESPNData(data) {
    // Parse ESPN response and convert to your format
    // This would be similar to your existing ESPN parsing logic
    const scores = [];
    
    if (data.events) {
      for (const event of data.events) {
        scores.push({
          gameId: event.id,
          homeTeam: {
            id: event.competitions[0].competitors[1].team.id,
            name: event.competitions[0].competitors[1].team.displayName,
            abbreviation: event.competitions[0].competitors[1].team.abbreviation,
            city: event.competitions[0].competitors[1].team.name,
            logoUrl: event.competitions[0].competitors[1].team.logo,
            color: event.competitions[0].competitors[1].team.color,
            alternateColor: event.competitions[0].competitors[1].team.alternateColor,
          },
          awayTeam: {
            id: event.competitions[0].competitors[0].team.id,
            name: event.competitions[0].competitors[0].team.displayName,
            abbreviation: event.competitions[0].competitors[0].team.abbreviation,
            city: event.competitions[0].competitors[0].team.name,
            logoUrl: event.competitions[0].competitors[0].team.logo,
            color: event.competitions[0].competitors[0].team.color,
            alternateColor: event.competitions[0].competitors[0].team.alternateColor,
          },
          homeScore: event.competitions[0].competitors[1].score,
          awayScore: event.competitions[0].competitors[0].score,
          status: event.status.type.name,
          quarter: event.competitions[0].status.period,
          timeRemaining: event.competitions[0].status.displayClock,
          isLive: event.status.type.name === 'STATUS_IN_PROGRESS',
          gameDate: event.date,
        });
      }
    }
    
    return scores;
  }

  getCurrentWeek() {
    // Implement your current week logic
    // This could be based on date, or stored in database
    return 4; // Example
  }
}

// Initialize ESPN polling service
const espnService = new ESPNPollingService();

// API Routes
app.get('/api/live-scores', (req, res) => {
  const { week, season } = req.query;
  
  // Check if cache is fresh
  if (lastUpdateTime && (Date.now() - lastUpdateTime) < CACHE_DURATION) {
    console.log('Serving cached live scores');
    return res.json({
      scores: liveScoresCache,
      lastUpdate: lastUpdateTime,
      cached: true
    });
  }
  
  // If cache is stale, return what we have but trigger refresh
  console.log('Cache stale, serving old data and refreshing');
  espnService.pollESPN();
  
  res.json({
    scores: liveScoresCache,
    lastUpdate: lastUpdateTime,
    cached: true,
    refreshing: true
  });
});

app.get('/api/health', (req, res) => {
  res.json({
    status: 'healthy',
    polling: espnService.isPolling,
    lastUpdate: lastUpdateTime,
    cacheAge: lastUpdateTime ? Date.now() - lastUpdateTime : null
  });
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  
  // Start ESPN polling
  espnService.startPolling();
});

// Graceful shutdown
process.on('SIGINT', () => {
  console.log('Shutting down server...');
  espnService.stopPolling();
  process.exit(0);
});
