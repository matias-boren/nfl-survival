-- Simple test to verify member count
-- Run this in your Supabase SQL Editor

-- Check if the specific league_members entry exists
SELECT 
    lm.league_id,
    lm.user_id,
    l.name as league_name
FROM league_members lm
JOIN leagues l ON lm.league_id = l.id
WHERE lm.league_id = 'b2d97471-b3f9-4116-b00b-715eab2faabd';

-- Count members for this specific league
SELECT COUNT(*) as member_count
FROM league_members 
WHERE league_id = 'b2d97471-b3f9-4116-b00b-715eab2faabd';

-- Check all league_members entries
SELECT 
    league_id,
    user_id,
    COUNT(*) as count
FROM league_members 
GROUP BY league_id, user_id
ORDER BY league_id;
