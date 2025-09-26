const axios = require('axios');
const cheerio = require('cheerio');
const { createClient } = require('@supabase/supabase-js');

// Configuration
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_KEY;
const OPENAI_API_KEY = process.env.OPENAI_API_KEY;

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

// NFL news sources to scrape
const NEWS_SOURCES = [
  {
    name: 'NFL.com',
    url: 'https://www.nfl.com/news',
    selectors: {
      articles: '.nfl-o-cta--primary',
      title: 'h3',
      summary: '.nfl-c-custom-promo__description',
      image: 'img',
      link: 'a'
    }
  },
  {
    name: 'ESPN',
    url: 'https://www.espn.com/nfl/',
    selectors: {
      articles: '.contentItem__contentWrapper',
      title: 'h1, h2, h3',
      summary: '.contentItem__subhead',
      image: 'img',
      link: 'a'
    }
  },
  {
    name: 'CBS Sports',
    url: 'https://www.cbssports.com/nfl/',
    selectors: {
      articles: '.article-list-item',
      title: 'h3, h4',
      summary: '.article-list-item__summary',
      image: 'img',
      link: 'a'
    }
  }
];

// Generate AI summary using OpenAI
async function generateAISummary(articleTitle, articleContent) {
  try {
    const response = await axios.post('https://api.openai.com/v1/chat/completions', {
      model: 'gpt-3.5-turbo',
      messages: [
        {
          role: 'system',
          content: 'You are an expert NFL reporter. Summarize NFL news articles in 2-3 engaging sentences. Keep it under 200 characters for the summary. Focus on the most important and interesting aspects for NFL fans.'
        },
        {
          role: 'user',
          content: `Summarize this NFL article: "${articleTitle}"\n\nContent: ${articleContent}`
        }
      ],
      max_tokens: 150,
      temperature: 0.7
    }, {
      headers: {
        'Authorization': `Bearer ${OPENAI_API_KEY}`,
        'Content-Type': 'application/json'
      }
    });

    return response.data.choices[0].message.content.trim();
  } catch (error) {
    console.error('Error generating AI summary:', error.message);
    return null;
  }
}

// Scrape news from a single source
async function scrapeNewsSource(source) {
  try {
    console.log(`Scraping ${source.name}...`);
    
    const response = await axios.get(source.url, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.5',
        'Accept-Encoding': 'gzip, deflate',
        'Connection': 'keep-alive'
      }
    });

    const $ = cheerio.load(response.data);
    const articles = [];

    $(source.selectors.articles).each((index, element) => {
      if (index >= 5) return; // Limit to 5 articles per source

      const $el = $(element);
      const title = $el.find(source.selectors.title).first().text().trim();
      const summary = $el.find(source.selectors.summary).first().text().trim();
      const image = $el.find(source.selectors.image).first().attr('src');
      const link = $el.find(source.selectors.link).first().attr('href');

      if (title && title.length > 10) {
        articles.push({
          title,
          summary: summary || 'Read more about this NFL story...',
          image: image ? (image.startsWith('/') ? `https://${new URL(source.url).host}${image}` : image) : null,
          link: link ? (link.startsWith('/') ? `https://${new URL(source.url).host}${link}` : link) : source.url,
          source: source.name,
          publishedAt: new Date().toISOString()
        });
      }
    });

    console.log(`Found ${articles.length} articles from ${source.name}`);
    return articles;
  } catch (error) {
    console.error(`Error scraping ${source.name}:`, error.message);
    return [];
  }
}

// Check if article is recent (less than 6 hours old)
function isRecentArticle(article) {
  const sixHoursAgo = new Date(Date.now() - 6 * 60 * 60 * 1000);
  const articleDate = new Date(article.publishedAt);
  return articleDate > sixHoursAgo;
}

// Check if article already exists in database
async function articleExists(title) {
  try {
    const { data, error } = await supabase
      .from('news_articles')
      .select('id')
      .eq('title', title)
      .single();

    return !error && data;
  } catch (error) {
    return false;
  }
}

// Save article to database
async function saveArticle(article) {
  try {
    const { data, error } = await supabase
      .from('news_articles')
      .insert([{
        title: article.title,
        summary: article.summary,
        content: article.content || article.summary,
        author: article.author || `${article.source} Staff`,
        published_at: article.publishedAt,
        image_url: article.image,
        source: article.source,
        url: article.link,
        category: 'NFL News',
        tags: article.tags || ['NFL', 'News'],
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      }])
      .select();

    if (error) {
      console.error('Error saving article:', error);
      return false;
    }

    console.log(`Saved article: ${article.title}`);
    return true;
  } catch (error) {
    console.error('Error saving article:', error);
    return false;
  }
}

// Main function to generate and save news
async function generateNews() {
  console.log('Starting AI news generation...');
  console.log(`Time: ${new Date().toISOString()}`);

  try {
    // Scrape articles from all sources
    const allArticles = [];
    for (const source of NEWS_SOURCES) {
      const articles = await scrapeNewsSource(source);
      allArticles.push(...articles);
    }

    // Filter for recent articles only
    const recentArticles = allArticles.filter(isRecentArticle);
    console.log(`Found ${recentArticles.length} recent articles`);

    if (recentArticles.length === 0) {
      console.log('No recent articles found. Exiting.');
      return;
    }

    // Process each article
    let processedCount = 0;
    for (const article of recentArticles) {
      // Check if article already exists
      if (await articleExists(article.title)) {
        console.log(`Article already exists: ${article.title}`);
        continue;
      }

      // Generate AI summary
      console.log(`Generating AI summary for: ${article.title}`);
      const aiSummary = await generateAISummary(article.title, article.summary);
      
      if (aiSummary) {
        article.summary = aiSummary;
        article.content = aiSummary + ' ' + (article.summary || '');
        article.tags = ['NFL', 'AI Generated', 'News'];
        article.author = 'AI NFL Reporter';
      }

      // Save to database
      const saved = await saveArticle(article);
      if (saved) {
        processedCount++;
      }

      // Add delay to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 1000));
    }

    console.log(`Successfully processed ${processedCount} articles`);
  } catch (error) {
    console.error('Error in news generation:', error);
  }
}

// Run the script
if (require.main === module) {
  generateNews()
    .then(() => {
      console.log('News generation completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('News generation failed:', error);
      process.exit(1);
    });
}

module.exports = { generateNews };
