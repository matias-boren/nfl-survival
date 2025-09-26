-- Fix the existing league by adding the owner to league_members
-- Run this in your Supabase SQL Editor

-- Add the owner to league_members for the existing league
INSERT INTO league_members (league_id, user_id)
VALUES (
    'b2d97471-b3f9-4116-b00b-715eab2faabd',
    'c3356d0a-b713-4a15-ac52-ba0d6309f25e'
)
ON CONFLICT (league_id, user_id) DO NOTHING;

-- Verify the insertion
SELECT lm.league_id, lm.user_id, l.name as league_name
FROM league_members lm
LEFT JOIN leagues l ON lm.league_id = l.id
WHERE lm.league_id = 'b2d97471-b3f9-4116-b00b-715eab2faabd';
