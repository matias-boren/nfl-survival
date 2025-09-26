-- Fix created_at_iso column issue
-- Run this in your Supabase SQL Editor

-- Add the missing created_at_iso column to leagues table
ALTER TABLE leagues ADD COLUMN IF NOT EXISTS created_at_iso VARCHAR(255);

-- Update existing records to have created_at_iso values
UPDATE leagues SET created_at_iso = created_at::text WHERE created_at_iso IS NULL;

-- Set default value for future records
ALTER TABLE leagues ALTER COLUMN created_at_iso SET DEFAULT NOW()::text;

-- Also add the missing columns that our code expects
ALTER TABLE leagues ADD COLUMN IF NOT EXISTS owner_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;
ALTER TABLE leagues ADD COLUMN IF NOT EXISTS season INTEGER DEFAULT 2025;
ALTER TABLE leagues ADD COLUMN IF NOT EXISTS invite_code VARCHAR(255);

-- Update owner_id to match creator_id for existing records
UPDATE leagues SET owner_id = creator_id WHERE owner_id IS NULL;

-- Create index for created_at_iso
CREATE INDEX IF NOT EXISTS idx_leagues_created_at_iso ON leagues(created_at_iso);
