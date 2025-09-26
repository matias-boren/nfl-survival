-- Fix infinite recursion in RLS policies
-- Run this in your Supabase SQL Editor

-- Drop ALL existing policies to avoid conflicts
DROP POLICY IF EXISTS "Users can create leagues" ON leagues;
DROP POLICY IF EXISTS "Users can view public leagues" ON leagues;
DROP POLICY IF EXISTS "Users can view leagues they own" ON leagues;
DROP POLICY IF EXISTS "Users can view leagues they created" ON leagues;
DROP POLICY IF EXISTS "Users can view leagues they are members of" ON leagues;
DROP POLICY IF EXISTS "League owners can update their leagues" ON leagues;
DROP POLICY IF EXISTS "League owners can delete their leagues" ON leagues;
DROP POLICY IF EXISTS "Users can join leagues" ON league_members;
DROP POLICY IF EXISTS "Users can leave leagues" ON league_members;
DROP POLICY IF EXISTS "Users can view league members" ON league_members;
DROP POLICY IF EXISTS "Users can view league members of their leagues" ON league_members;

-- Create simplified policies without recursion
CREATE POLICY "Users can create leagues" ON leagues
  FOR INSERT WITH CHECK (owner_id = auth.uid());

CREATE POLICY "Users can view public leagues" ON leagues
  FOR SELECT USING (visibility = 'public');

CREATE POLICY "Users can view leagues they own" ON leagues
  FOR SELECT USING (owner_id = auth.uid());

CREATE POLICY "Users can view leagues they are members of" ON leagues
  FOR SELECT USING (
    id IN (
      SELECT league_id FROM league_members WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "League owners can update their leagues" ON leagues
  FOR UPDATE USING (owner_id = auth.uid());

CREATE POLICY "League owners can delete their leagues" ON leagues
  FOR DELETE USING (owner_id = auth.uid());

-- Simplified league_members policies
CREATE POLICY "Users can join leagues" ON league_members
  FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can leave leagues" ON league_members
  FOR DELETE USING (user_id = auth.uid());

CREATE POLICY "Users can view league members" ON league_members
  FOR SELECT USING (true); -- Allow viewing all league members for now
