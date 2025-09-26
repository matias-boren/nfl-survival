-- Fix existing leagues by adding owners to league_members table
-- Run this in your Supabase SQL Editor

-- Add league owners to league_members table for existing leagues
INSERT INTO league_members (league_id, user_id)
SELECT 
    l.id as league_id,
    l.owner_id as user_id
FROM leagues l
WHERE NOT EXISTS (
    SELECT 1 FROM league_members lm 
    WHERE lm.league_id = l.id AND lm.user_id = l.owner_id
);

-- Also add members from the memberIds array if it exists
-- This is a more complex query that would need to be adapted based on your data structure
