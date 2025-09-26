-- Debug query to check leagues and league_members
-- Run this in your Supabase SQL Editor

-- Check all leagues
SELECT id, name, owner_id, creator_id, visibility, created_at_iso 
FROM leagues 
ORDER BY created_at_iso DESC;

-- Check all league_members
SELECT lm.league_id, lm.user_id, l.name as league_name
FROM league_members lm
LEFT JOIN leagues l ON lm.league_id = l.id
ORDER BY lm.league_id;

-- Check if there are any leagues without members
SELECT l.id, l.name, l.owner_id
FROM leagues l
LEFT JOIN league_members lm ON l.id = lm.league_id
WHERE lm.league_id IS NULL;
