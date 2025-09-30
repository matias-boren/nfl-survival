-- Temporarily disable RLS on league_invitations table for testing
-- This will help us determine if RLS is blocking the inserts

-- Disable RLS temporarily
ALTER TABLE league_invitations DISABLE ROW LEVEL SECURITY;

-- Drop the existing policy
DROP POLICY IF EXISTS "Allow all operations for authenticated users" ON league_invitations;

-- Grant all permissions
GRANT ALL ON league_invitations TO authenticated;
GRANT ALL ON league_invitations TO anon;
