-- Test direct count query for league_members
-- Run this in your Supabase SQL Editor

-- Method 1: Simple count
SELECT COUNT(*) as member_count
FROM league_members 
WHERE league_id = 'b2d97471-b3f9-4116-b00b-715eab2faabd';

-- Method 2: Count with league info
SELECT 
    l.id,
    l.name,
    COUNT(lm.user_id) as member_count
FROM leagues l
LEFT JOIN league_members lm ON l.id = lm.league_id
WHERE l.id = 'b2d97471-b3f9-4116-b00b-715eab2faabd'
GROUP BY l.id, l.name;

-- Method 3: Check what's actually in league_members
SELECT * FROM league_members 
WHERE league_id = 'b2d97471-b3f9-4116-b00b-715eab2faabd';
