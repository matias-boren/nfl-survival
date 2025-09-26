-- Test query to check league_members data
-- Run this in your Supabase SQL Editor

-- Check if the league_members entry exists
SELECT * FROM league_members WHERE league_id = 'b2d97471-b3f9-4116-b00b-715eab2faabd';

-- Test the join query that our app is using
SELECT l.*, lm.* 
FROM leagues l
LEFT JOIN league_members lm ON l.id = lm.league_id
WHERE l.id = 'b2d97471-b3f9-4116-b00b-715eab2faabd';

-- Test the exact query our app uses
SELECT *, league_members(*)
FROM leagues 
WHERE owner_id = 'c3356d0a-b713-4a15-ac52-ba0d6309f25e';
