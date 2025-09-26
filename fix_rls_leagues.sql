-- Fix RLS policies for leagues table to allow league creation
-- Run this in your Supabase SQL Editor

-- Drop existing problematic policies
DROP POLICY IF EXISTS "Users can create leagues" ON leagues;
DROP POLICY IF EXISTS "Users can view public leagues" ON leagues;
DROP POLICY IF EXISTS "Users can view leagues they created" ON leagues;

-- Create new policies that work with the updated schema
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

-- Also ensure league_members policies work correctly
DROP POLICY IF EXISTS "Users can join leagues" ON league_members;
DROP POLICY IF EXISTS "Users can leave leagues" ON league_members;

CREATE POLICY "Users can join leagues" ON league_members
  FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can leave leagues" ON league_members
  FOR DELETE USING (user_id = auth.uid());

CREATE POLICY "Users can view league members" ON league_members
  FOR SELECT USING (
    user_id = auth.uid() OR 
    league_id IN (
      SELECT id FROM leagues WHERE owner_id = auth.uid()
    )
  );
