-- Check the structure of the existing news_articles table
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'news_articles' 
ORDER BY ordinal_position;

-- Check if there are any existing articles
SELECT COUNT(*) as total_articles FROM news_articles;

-- Check the most recent articles
SELECT 
    title, 
    source, 
    published_at, 
    created_at
FROM news_articles 
ORDER BY published_at DESC 
LIMIT 5;
