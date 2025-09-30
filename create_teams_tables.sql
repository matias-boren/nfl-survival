-- Create teams table
CREATE TABLE IF NOT EXISTS teams (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  espn_team_id VARCHAR(50) UNIQUE NOT NULL,
  name VARCHAR(100) NOT NULL,
  abbreviation VARCHAR(10) NOT NULL,
  city VARCHAR(50) NOT NULL,
  conference VARCHAR(10) NOT NULL,
  division VARCHAR(20) NOT NULL,
  logo_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create team_records table
CREATE TABLE IF NOT EXISTS team_records (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  team_id UUID REFERENCES teams(id) NOT NULL,
  season INTEGER NOT NULL,
  week INTEGER NOT NULL,
  wins INTEGER DEFAULT 0,
  losses INTEGER DEFAULT 0,
  ties INTEGER DEFAULT 0,
  last_updated TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(team_id, season, week)
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_teams_espn_id ON teams(espn_team_id);
CREATE INDEX IF NOT EXISTS idx_teams_abbreviation ON teams(abbreviation);
CREATE INDEX IF NOT EXISTS idx_team_records_team_season ON team_records(team_id, season);
CREATE INDEX IF NOT EXISTS idx_team_records_season_week ON team_records(season, week);

-- Enable RLS
ALTER TABLE teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE team_records ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
-- Anyone can read teams and records
CREATE POLICY "Anyone can read teams" ON teams FOR SELECT USING (true);
CREATE POLICY "Anyone can read team records" ON team_records FOR SELECT USING (true);

-- Only service role can manage teams and records
CREATE POLICY "Service role can manage teams" ON teams FOR ALL USING (auth.role() = 'service_role');
CREATE POLICY "Service role can manage team records" ON team_records FOR ALL USING (auth.role() = 'service_role');

-- Create function to update updated_at timestamp for teams
CREATE OR REPLACE FUNCTION update_teams_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for teams updated_at
CREATE TRIGGER update_teams_updated_at
  BEFORE UPDATE ON teams
  FOR EACH ROW
  EXECUTE FUNCTION update_teams_updated_at();
