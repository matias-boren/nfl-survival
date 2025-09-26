-- Test member count query for the specific league
-- Run this in your Supabase SQL Editor

SELECT 
    l.id,
    l.name,
    COUNT(lm.user_id) as member_count
FROM leagues l
LEFT JOIN league_members lm ON l.id = lm.league_id
WHERE l.id = 'b2d97471-b3f9-4116-b00b-715eab2faabd'
GROUP BY l.id, l.name;
