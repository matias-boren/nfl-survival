-- Final fix for creator_id column in leagues table
-- Run this in your Supabase SQL Editor

-- First, let's check if creator_id exists and what type it is
-- If it doesn't exist, create it
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'leagues' AND column_name = 'creator_id') THEN
        ALTER TABLE leagues ADD COLUMN creator_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Make sure creator_id is NOT NULL and has a default
ALTER TABLE leagues ALTER COLUMN creator_id SET NOT NULL;

-- Update existing records to have creator_id = owner_id
UPDATE leagues SET creator_id = owner_id WHERE creator_id IS NULL;

-- Also ensure owner_id exists
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'leagues' AND column_name = 'owner_id') THEN
        ALTER TABLE leagues ADD COLUMN owner_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Update existing records to have owner_id = creator_id if owner_id is null
UPDATE leagues SET owner_id = creator_id WHERE owner_id IS NULL;
