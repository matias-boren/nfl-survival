-- Drop the existing league_invitations table and recreate it
-- This will fix any column name mismatches

-- First, drop the table (this will also drop all data)
DROP TABLE IF EXISTS league_invitations CASCADE;

-- Recreate the table with correct column names
CREATE TABLE league_invitations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  "leagueId" UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
  "invitedByUserId" UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  "invitedUserEmail" TEXT,
  "invitedUserId" UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  "invitationCode" TEXT NOT NULL UNIQUE,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'declined', 'expired')),
  "createdAt" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  "expiresAt" TIMESTAMP WITH TIME ZONE,
  "acceptedAt" TIMESTAMP WITH TIME ZONE,
  "declinedAt" TIMESTAMP WITH TIME ZONE
);

-- Create indexes for better performance
CREATE INDEX idx_league_invitations_league_id ON league_invitations("leagueId");
CREATE INDEX idx_league_invitations_invitation_code ON league_invitations("invitationCode");
CREATE INDEX idx_league_invitations_invited_by_user_id ON league_invitations("invitedByUserId");
CREATE INDEX idx_league_invitations_invited_user_id ON league_invitations("invitedUserId");
CREATE INDEX idx_league_invitations_status ON league_invitations(status);

-- Enable RLS
ALTER TABLE league_invitations ENABLE ROW LEVEL SECURITY;

-- Simple RLS policy - allow all operations for authenticated users
CREATE POLICY "Allow all operations for authenticated users" ON league_invitations
    FOR ALL
    USING (auth.uid() IS NOT NULL)
    WITH CHECK (auth.uid() IS NOT NULL);

-- Grant permissions
GRANT ALL ON league_invitations TO authenticated;
GRANT ALL ON league_invitations TO anon;
