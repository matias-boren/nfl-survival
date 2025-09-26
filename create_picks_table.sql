-- Create picks table for Supabase
-- Run this in your Supabase SQL Editor

-- Create picks table
CREATE TABLE IF NOT EXISTS picks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    league_id UUID REFERENCES leagues(id) ON DELETE CASCADE NOT NULL,
    team_id VARCHAR(10) NOT NULL,
    week INTEGER NOT NULL,
    result VARCHAR(20) DEFAULT 'PENDING' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    
    -- Ensure one pick per user per league per week
    UNIQUE(user_id, league_id, week)
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_picks_user_league ON picks(user_id, league_id);
CREATE INDEX IF NOT EXISTS idx_picks_league_week ON picks(league_id, week);
CREATE INDEX IF NOT EXISTS idx_picks_user_id ON picks(user_id);
CREATE INDEX IF NOT EXISTS idx_picks_league_id ON picks(league_id);

-- Enable RLS
ALTER TABLE picks ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Users can view their own picks" ON picks;
DROP POLICY IF EXISTS "Users can view picks in their leagues" ON picks;
DROP POLICY IF EXISTS "Users can create picks in their leagues" ON picks;
DROP POLICY IF EXISTS "Users can update their own picks" ON picks;
DROP POLICY IF EXISTS "League owners can update picks in their leagues" ON picks;

-- Create RLS policies
CREATE POLICY "Users can view their own picks" ON picks
    FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "Users can view picks in their leagues" ON picks
    FOR SELECT USING (
        league_id IN (
            SELECT id FROM leagues WHERE creator_id = auth.uid()
        )
        OR league_id IN (
            SELECT league_id FROM league_members WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can create picks in their leagues" ON picks
    FOR INSERT WITH CHECK (
        user_id = auth.uid()
        AND league_id IN (
            SELECT id FROM leagues WHERE creator_id = auth.uid()
        )
        OR league_id IN (
            SELECT league_id FROM league_members WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can update their own picks" ON picks
    FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY "League owners can update picks in their leagues" ON picks
    FOR UPDATE USING (
        league_id IN (
            SELECT id FROM leagues WHERE creator_id = auth.uid()
        )
    );
