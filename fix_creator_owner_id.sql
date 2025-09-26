-- Fix creator_id and owner_id compatibility in RLS policies
-- Run this in your Supabase SQL Editor

-- Drop existing policies
DROP POLICY IF EXISTS "Users can create leagues" ON leagues;
DROP POLICY IF EXISTS "Users can view leagues they own" ON leagues;
DROP POLICY IF EXISTS "League owners can update their leagues" ON leagues;
DROP POLICY IF EXISTS "League owners can delete their leagues" ON leagues;

-- Create policies that work with both creator_id and owner_id
CREATE POLICY "Users can create leagues" ON leagues
  FOR INSERT WITH CHECK (creator_id = auth.uid() OR owner_id = auth.uid());

CREATE POLICY "Users can view leagues they own" ON leagues
  FOR SELECT USING (creator_id = auth.uid() OR owner_id = auth.uid());

CREATE POLICY "League owners can update their leagues" ON leagues
  FOR UPDATE USING (creator_id = auth.uid() OR owner_id = auth.uid());

CREATE POLICY "League owners can delete their leagues" ON leagues
  FOR DELETE USING (creator_id = auth.uid() OR owner_id = auth.uid());

-- Also update the league_members policies to work with both
DROP POLICY IF EXISTS "Users can view league members" ON league_members;

CREATE POLICY "Users can view league members" ON league_members
  FOR SELECT USING (
    user_id = auth.uid() OR
    league_id IN (
      SELECT id FROM leagues WHERE creator_id = auth.uid() OR owner_id = auth.uid()
    )
  );
