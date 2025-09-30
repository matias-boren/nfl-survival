-- Test inserting a news article to verify the table structure and connection
INSERT INTO news_articles (
    title,
    summary,
    content,
    author,
    published_at,
    image_url,
    source,
    url,
    category,
    tags
) VALUES (
    'Test Article: NFL News Generation Working',
    'This is a test article to verify the news generation system is working properly.',
    'This is a test article created to verify that the news generation system can successfully insert articles into the database. If you can see this article in the news feed, it means the SupabaseNewsRepository is working correctly and the table structure is compatible.',
    'Test Author',
    NOW(),
    'https://picsum.photos/400/200?random=test',
    'Test Source',
    'https://example.com/test-article',
    'NFL News',
    ARRAY['test', 'nfl', 'news']
);

-- Check if the article was inserted
SELECT 
    title, 
    source, 
    published_at, 
    created_at
FROM news_articles 
ORDER BY created_at DESC 
LIMIT 1;
