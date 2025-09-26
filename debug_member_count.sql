-- Debug member count issue
-- Run this in your Supabase SQL Editor

-- 1. Check if the league exists
SELECT id, name, creator_id, owner_id FROM leagues 
WHERE id = 'b2d97471-b3f9-4116-b00b-715eab2faabd';

-- 2. Check league_members table for this league
SELECT * FROM league_members 
WHERE league_id = 'b2d97471-b3f9-4116-b00b-715eab2faabd';

-- 3. Count members for this league
SELECT COUNT(*) as member_count
FROM league_members 
WHERE league_id = 'b2d97471-b3f9-4116-b00b-715eab2faabd';

-- 4. Check if there are any league_members at all
SELECT COUNT(*) as total_league_members FROM league_members;

-- 5. Check all leagues and their member counts
SELECT 
    l.id,
    l.name,
    COUNT(lm.user_id) as member_count
FROM leagues l
LEFT JOIN league_members lm ON l.id = lm.league_id
GROUP BY l.id, l.name
ORDER BY l.created_at DESC;
