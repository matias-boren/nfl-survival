-- Create leagues table
CREATE TABLE IF NOT EXISTS leagues (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  creator_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  max_losses INTEGER NOT NULL DEFAULT 3,
  max_users INTEGER NOT NULL DEFAULT 10,
  visibility VARCHAR(20) NOT NULL DEFAULT 'private',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create league_members table
CREATE TABLE IF NOT EXISTS league_members (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(league_id, user_id)
);

-- Create picks table
CREATE TABLE IF NOT EXISTS picks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
  week INTEGER NOT NULL,
  season INTEGER NOT NULL,
  team_id VARCHAR(10) NOT NULL,
  team_name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  result VARCHAR(20) DEFAULT 'PENDING',
  UNIQUE(user_id, league_id, week, season)
);

-- Create user_profiles table
CREATE TABLE IF NOT EXISTS user_profiles (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE,
  display_name VARCHAR(100),
  favorite_team VARCHAR(100),
  is_premium BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create league_invitations table
CREATE TABLE IF NOT EXISTS league_invitations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
  inviter_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  invitee_email VARCHAR(255),
  token VARCHAR(255) UNIQUE NOT NULL,
  status VARCHAR(20) DEFAULT 'PENDING',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  expires_at TIMESTAMP WITH TIME ZONE DEFAULT (NOW() + INTERVAL '7 days')
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_leagues_creator_id ON leagues(creator_id);
CREATE INDEX IF NOT EXISTS idx_leagues_visibility ON leagues(visibility);
CREATE INDEX IF NOT EXISTS idx_league_members_league_id ON league_members(league_id);
CREATE INDEX IF NOT EXISTS idx_league_members_user_id ON league_members(user_id);
CREATE INDEX IF NOT EXISTS idx_picks_user_id ON picks(user_id);
CREATE INDEX IF NOT EXISTS idx_picks_league_id ON picks(league_id);
CREATE INDEX IF NOT EXISTS idx_picks_week_season ON picks(week, season);
CREATE INDEX IF NOT EXISTS idx_user_profiles_user_id ON user_profiles(user_id);
CREATE INDEX IF NOT EXISTS idx_league_invitations_token ON league_invitations(token);
CREATE INDEX IF NOT EXISTS idx_league_invitations_league_id ON league_invitations(league_id);

-- Enable Row Level Security (RLS)
ALTER TABLE leagues ENABLE ROW LEVEL SECURITY;
ALTER TABLE league_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE picks ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE league_invitations ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for leagues
CREATE POLICY "Users can view public leagues" ON leagues
  FOR SELECT USING (visibility = 'public');

CREATE POLICY "Users can view leagues they created" ON leagues
  FOR SELECT USING (creator_id = auth.uid());

CREATE POLICY "Users can view leagues they are members of" ON leagues
  FOR SELECT USING (
    id IN (
      SELECT league_id FROM league_members WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Users can create leagues" ON leagues
  FOR INSERT WITH CHECK (creator_id = auth.uid());

CREATE POLICY "League creators can update their leagues" ON leagues
  FOR UPDATE USING (creator_id = auth.uid());

CREATE POLICY "League creators can delete their leagues" ON leagues
  FOR DELETE USING (creator_id = auth.uid());

-- Create RLS policies for league_members
CREATE POLICY "Users can view league members of their leagues" ON league_members
  FOR SELECT USING (
    league_id IN (
      SELECT id FROM leagues WHERE creator_id = auth.uid()
    )
    OR user_id = auth.uid()
  );

CREATE POLICY "Users can join leagues" ON league_members
  FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can leave leagues" ON league_members
  FOR DELETE USING (user_id = auth.uid());

-- Create RLS policies for picks
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

CREATE POLICY "Users can update their own picks" ON picks
  FOR UPDATE USING (user_id = auth.uid());

-- Create RLS policies for user_profiles
CREATE POLICY "Users can view all profiles" ON user_profiles
  FOR SELECT USING (true);

CREATE POLICY "Users can create their own profile" ON user_profiles
  FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own profile" ON user_profiles
  FOR UPDATE USING (user_id = auth.uid());

-- Create RLS policies for league_invitations
CREATE POLICY "Users can view invitations for their leagues" ON league_invitations
  FOR SELECT USING (
    league_id IN (
      SELECT id FROM leagues WHERE creator_id = auth.uid()
    )
  );

CREATE POLICY "League creators can create invitations" ON league_invitations
  FOR INSERT WITH CHECK (
    league_id IN (
      SELECT id FROM leagues WHERE creator_id = auth.uid()
    )
  );

CREATE POLICY "Users can update invitation status" ON league_invitations
  FOR UPDATE USING (true);
