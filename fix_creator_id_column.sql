-- Fix creator_id column issue in leagues table
-- Run this in your Supabase SQL Editor

-- Make creator_id nullable since we're using owner_id
ALTER TABLE leagues ALTER COLUMN creator_id DROP NOT NULL;

-- Update existing records to have creator_id = owner_id
UPDATE leagues SET creator_id = owner_id WHERE creator_id IS NULL;

-- Or alternatively, we can populate creator_id from owner_id in our code
-- Let's update our Supabase repository to send both fields
