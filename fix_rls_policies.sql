-- Fix RLS policies to prevent infinite recursion
-- Run this in your Supabase SQL Editor

-- Drop existing problematic policies
DROP POLICY IF EXISTS "Users can view league members of their leagues" ON league_members;
DROP POLICY IF EXISTS "Users can view picks in their leagues" ON picks;
DROP POLICY IF EXISTS "Users can create picks in their leagues" ON picks;

-- Recreate league_members policies without recursion
CREATE POLICY "Users can view league members of their leagues" ON league_members
  FOR SELECT USING (
    league_id IN (
      SELECT id FROM leagues WHERE creator_id = auth.uid()
    )
    OR user_id = auth.uid()
  );

-- Recreate picks policies without recursion
CREATE POLICY "Users can view picks in their leagues" ON picks
  FOR SELECT USING (
    user_id = auth.uid()
    OR league_id IN (
      SELECT id FROM leagues WHERE creator_id = auth.uid()
    )
  );

CREATE POLICY "Users can create picks in their leagues" ON picks
  FOR INSERT WITH CHECK (
    user_id = auth.uid()
  );
