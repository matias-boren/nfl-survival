const axios = require('axios');
const cheerio = require('cheerio');

class NewsScrapingService {
  constructor() {
    this.sources = [
      {
        name: 'ESPN NFL',
        url: 'https://www.espn.com/nfl/news',
        selector: '.headlineStack__list .contentItem',
        titleSelector: '.contentItem__title a',
        linkSelector: '.contentItem__title a',
        contentSelector: '.contentItem__subhead',
        baseUrl: 'https://www.espn.com'
      },
      {
        name: 'NFL.com',
        url: 'https://www.nfl.com/news',
        selector: '.nfl-c-card-grid__item',
        titleSelector: '.nfl-c-card__title a',
        linkSelector: '.nfl-c-card__title a',
        contentSelector: '.nfl-c-card__summary',
        baseUrl: 'https://www.nfl.com'
      },
      {
        name: 'CBS Sports NFL',
        url: 'https://www.cbssports.com/nfl/news',
        selector: '.Article',
        titleSelector: '.Article-title a',
        linkSelector: '.Article-title a',
        contentSelector: '.Article-summary',
        baseUrl: 'https://www.cbssports.com'
      }
    ];
    
    this.axiosConfig = {
      timeout: 10000,
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
      }
    };
  }

  async scrapeLatestNews() {
    const allArticles = [];
    
    for (const source of this.sources) {
      try {
        console.log(`🔍 Scraping ${source.name}...`);
        const articles = await this.scrapeSource(source);
        allArticles.push(...articles);
        console.log(`✅ Found ${articles.length} articles from ${source.name}`);
        
        // Add delay between sources to be respectful
        await this.delay(2000);
      } catch (error) {
        console.error(`❌ Error scraping ${source.name}:`, error.message);
      }
    }
    
    // Remove duplicates and filter recent articles
    const uniqueArticles = this.removeDuplicates(allArticles);
    const recentArticles = this.filterRecentArticles(uniqueArticles);
    
    console.log(`📊 Total unique recent articles: ${recentArticles.length}`);
    return recentArticles;
  }

  async scrapeSource(source) {
    try {
      const response = await axios.get(source.url, this.axiosConfig);
      const $ = cheerio.load(response.data);
      const articles = [];

      $(source.selector).each((index, element) => {
        try {
          // Limit to first 10 articles per source
          if (index >= 10) return false;

          const $element = $(element);
          const title = $element.find(source.titleSelector).text().trim();
          const relativeLink = $element.find(source.linkSelector).attr('href');
          const content = $element.find(source.contentSelector).text().trim();

          if (!title || !relativeLink) return;

          // Build full URL
          let fullUrl = relativeLink;
          if (relativeLink.startsWith('/')) {
            fullUrl = source.baseUrl + relativeLink;
          } else if (!relativeLink.startsWith('http')) {
            fullUrl = source.baseUrl + '/' + relativeLink;
          }

          // Generate a simple ID from URL
          const id = this.generateArticleId(fullUrl);

          articles.push({
            id,
            title,
            content: content || title, // Use title as fallback content
            url: fullUrl,
            source: source.name,
            publishedAt: new Date(),
            imageUrl: this.generatePlaceholderImage(index)
          });
        } catch (error) {
          console.error(`Error processing article element:`, error.message);
        }
      });

      return articles;
    } catch (error) {
      console.error(`Error fetching ${source.url}:`, error.message);
      return [];
    }
  }

  generateArticleId(url) {
    // Simple hash function for URL
    let hash = 0;
    for (let i = 0; i < url.length; i++) {
      const char = url.charCodeAt(i);
      hash = ((hash << 5) - hash) + char;
      hash = hash & hash; // Convert to 32-bit integer
    }
    return Math.abs(hash).toString();
  }

  generatePlaceholderImage(index) {
    // Generate placeholder images for articles
    const imageIds = [100, 101, 102, 103, 104, 105, 106, 107, 108, 109];
    const imageId = imageIds[index % imageIds.length];
    return `https://picsum.photos/400/200?random=${imageId}`;
  }

  removeDuplicates(articles) {
    const seen = new Set();
    return articles.filter(article => {
      const key = article.title.toLowerCase().replace(/[^a-z0-9]/g, '');
      if (seen.has(key)) {
        return false;
      }
      seen.add(key);
      return true;
    });
  }

  filterRecentArticles(articles) {
    const sixHoursAgo = new Date(Date.now() - 6 * 60 * 60 * 1000);
    return articles.filter(article => {
      // For scraped articles, we assume they're recent
      // In a more sophisticated implementation, we'd parse publish dates
      return true;
    });
  }

  delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}

module.exports = NewsScrapingService;
