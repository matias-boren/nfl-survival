-- Fix picks table schema to include missing columns
-- This addresses the PGRST204 error about missing 'updated_at' column

-- Add updated_at column if it doesn't exist
ALTER TABLE picks 
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- Add created_at column if it doesn't exist  
ALTER TABLE picks 
ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT NOW();

-- Add locked column if it doesn't exist
ALTER TABLE picks 
ADD COLUMN IF NOT EXISTS locked BOOLEAN DEFAULT FALSE;

-- Add season column if it doesn't exist
ALTER TABLE picks 
ADD COLUMN IF NOT EXISTS season INTEGER DEFAULT 2025;

-- Add team_name column if it doesn't exist
ALTER TABLE picks 
ADD COLUMN IF NOT EXISTS team_name TEXT;

-- Update existing records to have proper timestamps
UPDATE picks 
SET created_at = NOW() 
WHERE created_at IS NULL;

UPDATE picks 
SET updated_at = NOW() 
WHERE updated_at IS NULL;

UPDATE picks 
SET season = 2025 
WHERE season IS NULL;

UPDATE picks 
SET team_name = team_id 
WHERE team_name IS NULL;

-- Make created_at NOT NULL
ALTER TABLE picks 
ALTER COLUMN created_at SET NOT NULL;

-- Make updated_at NOT NULL
ALTER TABLE picks 
ALTER COLUMN updated_at SET NOT NULL;

-- Make season NOT NULL
ALTER TABLE picks 
ALTER COLUMN season SET NOT NULL;

-- Make team_name NOT NULL
ALTER TABLE picks 
ALTER COLUMN team_name SET NOT NULL;

-- Add indexes for better performance
CREATE INDEX IF NOT EXISTS idx_picks_user_league_week ON picks(user_id, league_id, week);
CREATE INDEX IF NOT EXISTS idx_picks_league_week ON picks(league_id, week);
CREATE INDEX IF NOT EXISTS idx_picks_user_league ON picks(user_id, league_id);

-- Add unique constraint to ensure one pick per user per league per week
-- This prevents duplicate picks (survival pool = one pick per week)
-- First drop the constraint if it exists, then add it
DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_user_league_week_pick') THEN
        ALTER TABLE picks DROP CONSTRAINT unique_user_league_week_pick;
    END IF;
END $$;

ALTER TABLE picks 
ADD CONSTRAINT unique_user_league_week_pick 
UNIQUE (user_id, league_id, week);

-- Verify the table structure
SELECT column_name, data_type, is_nullable, column_default 
FROM information_schema.columns 
WHERE table_name = 'picks' 
ORDER BY ordinal_position;
