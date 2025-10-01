-- Add losses column to league_members table
-- This tracks how many losses each user has in each league

ALTER TABLE league_members 
ADD COLUMN losses INTEGER DEFAULT 0;

-- Add constraint to ensure losses is non-negative
ALTER TABLE league_members 
ADD CONSTRAINT check_losses_non_negative CHECK (losses >= 0);

-- Update existing records to have 0 losses
UPDATE league_members 
SET losses = 0 
WHERE losses IS NULL;

-- Make losses column NOT NULL
ALTER TABLE league_members 
ALTER COLUMN losses SET NOT NULL;

-- Add index for efficient querying by losses
CREATE INDEX idx_league_members_losses ON league_members(league_id, losses);

-- Verify the changes
SELECT 
    league_id, 
    user_id, 
    losses, 
    joined_at 
FROM league_members 
ORDER BY league_id, losses DESC;
