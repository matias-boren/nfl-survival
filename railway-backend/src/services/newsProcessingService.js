class NewsProcessingService {
  constructor(supabase, openai) {
    this.supabase = supabase;
    this.openai = openai;
  }

  async processArticles(articles) {
    const results = {
      total: articles.length,
      processed: 0,
      skipped: 0,
      errors: []
    };

    for (const article of articles) {
      try {
        // Check if article already exists
        const exists = await this.articleExists(article.url);
        if (exists) {
          console.log(`⏭️ Skipping existing article: ${article.title}`);
          results.skipped++;
          continue;
        }

        // Process with AI
        console.log(`🤖 Processing: ${article.title}`);
        const processedArticle = await this.processWithAI(article);
        
        // Save to database
        await this.saveArticle(processedArticle);
        results.processed++;
        
        console.log(`✅ Saved: ${article.title}`);
        
        // Rate limiting delay
        await this.delay(2000);
      } catch (error) {
        console.error(`❌ Error processing article "${article.title}":`, error.message);
        results.errors.push({
          title: article.title,
          error: error.message
        });
      }
    }

    return results;
  }

  async articleExists(url) {
    try {
      const { data, error } = await this.supabase
        .from('news_articles')
        .select('id')
        .eq('url', url)
        .maybeSingle();
      
      if (error) {
        console.error('Error checking article existence:', error);
        return false;
      }
      
      return data !== null;
    } catch (error) {
      console.error('Error checking if article exists:', error);
      return false;
    }
  }

  async processWithAI(article) {
    try {
      // Generate AI summary
      const summary = await this.generateSummary(article);
      
      // Generate tags
      const tags = await this.generateTags(article);
      
      return {
        ...article,
        summary,
        tags,
        author: 'AI Reporter'
      };
    } catch (error) {
      console.error('Error processing with AI:', error);
      // Return article with fallback data if AI processing fails
      return {
        ...article,
        summary: article.content || article.title,
        tags: ['NFL', 'News'],
        author: 'AI Reporter'
      };
    }
  }

  async generateSummary(article) {
    try {
      const prompt = `Summarize this NFL news article in 2-3 sentences. Make it engaging and informative for fantasy football and NFL survival pool players.

Title: ${article.title}
Content: ${article.content}
Source: ${article.source}

Summary:`;

      const response = await this.openai.chat.completions.create({
        model: "gpt-3.5-turbo",
        messages: [
          {
            role: "system",
            content: "You are an expert NFL analyst writing summaries for fantasy football and survival pool players. Keep summaries concise, engaging, and focused on actionable insights."
          },
          {
            role: "user",
            content: prompt
          }
        ],
        max_tokens: 150,
        temperature: 0.7
      });

      return response.choices[0]?.message?.content?.trim() || article.content;
    } catch (error) {
      console.error('Error generating summary:', error);
      return article.content || article.title;
    }
  }

  async generateTags(article) {
    try {
      const prompt = `Generate 3-5 relevant tags for this NFL article. Focus on teams, players, fantasy football, and survival pool relevance.

Title: ${article.title}
Content: ${article.content}

Return only the tags as a comma-separated list:`;

      const response = await this.openai.chat.completions.create({
        model: "gpt-3.5-turbo",
        messages: [
          {
            role: "system",
            content: "Generate relevant tags for NFL articles. Include team names, player names, and categories like 'fantasy', 'injury', 'trade', 'survival-pool', etc."
          },
          {
            role: "user",
            content: prompt
          }
        ],
        max_tokens: 50,
        temperature: 0.5
      });

      const tagsString = response.choices[0]?.message?.content?.trim();
      if (tagsString) {
        const tags = tagsString
          .split(',')
          .map(tag => tag.trim().toLowerCase())
          .filter(tag => tag.length > 0)
          .slice(0, 5); // Limit to 5 tags
        
        return tags.length > 0 ? tags : ['nfl', 'news'];
      }
      
      return ['nfl', 'news'];
    } catch (error) {
      console.error('Error generating tags:', error);
      return ['nfl', 'news'];
    }
  }

  async saveArticle(article) {
    try {
      const { data, error } = await this.supabase
        .from('news_articles')
        .insert({
          title: article.title,
          summary: article.summary,
          content: article.content,
          author: article.author,
          published_at: article.publishedAt.toISOString(),
          image_url: article.imageUrl,
          source: article.source,
          url: article.url,
          category: 'NFL News',
          tags: article.tags
        })
        .select()
        .single();

      if (error) {
        throw new Error(`Supabase error: ${error.message}`);
      }

      return data;
    } catch (error) {
      console.error('Error saving article to database:', error);
      throw error;
    }
  }

  delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}

module.exports = NewsProcessingService;
