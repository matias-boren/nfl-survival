-- Fix league schema to add missing columns and implement points system
-- Run this in your Supabase SQL Editor

-- First, add the missing columns that the update script expects
ALTER TABLE leagues ADD COLUMN IF NOT EXISTS allow_team_reuse BOOLEAN DEFAULT true;
ALTER TABLE leagues ADD COLUMN IF NOT EXISTS auto_eliminate_on_no_pick BOOLEAN DEFAULT true;

-- Add member_points column to leagues table
ALTER TABLE leagues ADD COLUMN IF NOT EXISTS member_points JSONB DEFAULT '{}';

-- Remove unnecessary columns from leagues table (if they exist)
ALTER TABLE leagues DROP COLUMN IF EXISTS max_teams;
ALTER TABLE leagues DROP COLUMN IF EXISTS min_teams;
ALTER TABLE leagues DROP COLUMN IF EXISTS tiebreaker;

-- Update existing leagues to have default settings
UPDATE leagues SET 
  member_points = '{}',
  allow_team_reuse = COALESCE(allow_team_reuse, true),
  auto_eliminate_on_no_pick = COALESCE(auto_eliminate_on_no_pick, true)
WHERE member_points IS NULL;

-- Create index for member_points queries
CREATE INDEX IF NOT EXISTS idx_leagues_member_points ON leagues USING GIN (member_points);

-- Add function to update member points
CREATE OR REPLACE FUNCTION update_member_points(
  league_id_param UUID,
  user_id_param UUID,
  points_param INTEGER
) RETURNS VOID AS $$
BEGIN
  UPDATE leagues 
  SET member_points = COALESCE(member_points, '{}'::jsonb) || 
                     jsonb_build_object(user_id_param::text, points_param)
  WHERE id = league_id_param;
END;
$$ LANGUAGE plpgsql;

-- Add function to get member points
CREATE OR REPLACE FUNCTION get_member_points(
  league_id_param UUID,
  user_id_param UUID
) RETURNS INTEGER AS $$
DECLARE
  points INTEGER;
BEGIN
  SELECT COALESCE((member_points->>user_id_param::text)::INTEGER, 0)
  INTO points
  FROM leagues 
  WHERE id = league_id_param;
  
  RETURN points;
END;
$$ LANGUAGE plpgsql;
