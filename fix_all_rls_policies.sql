-- Comprehensive RLS policy fixes for NFL Survival app
-- This script ensures all tables have proper RLS policies

-- ==============================================
-- CHAT_MESSAGES TABLE
-- ==============================================

-- Drop existing policies
DROP POLICY IF EXISTS "Users can read chat messages for leagues they belong to" ON chat_messages;
DROP POLICY IF EXISTS "Users can insert chat messages for leagues they belong to" ON chat_messages;
DROP POLICY IF EXISTS "Users can update their own chat messages" ON chat_messages;
DROP POLICY IF EXISTS "Users can delete their own chat messages" ON chat_messages;

-- Create new policies
CREATE POLICY "Users can read chat messages for leagues they belong to" ON chat_messages
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = chat_messages.league_id
            AND lm.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert chat messages for leagues they belong to" ON chat_messages
    FOR INSERT
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = chat_messages.league_id
            AND lm.user_id = auth.uid()
        )
        AND user_id = auth.uid()
    );

CREATE POLICY "Users can update their own chat messages" ON chat_messages
    FOR UPDATE
    USING (
        user_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = chat_messages.league_id
            AND lm.user_id = auth.uid()
        )
    )
    WITH CHECK (
        user_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = chat_messages.league_id
            AND lm.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can delete their own chat messages" ON chat_messages
    FOR DELETE
    USING (
        user_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = chat_messages.league_id
            AND lm.user_id = auth.uid()
        )
    );

-- ==============================================
-- LEAGUES TABLE
-- ==============================================

-- Drop existing policies
DROP POLICY IF EXISTS "Users can read leagues they belong to" ON leagues;
DROP POLICY IF EXISTS "Users can create leagues" ON leagues;
DROP POLICY IF EXISTS "League owners can update their leagues" ON leagues;
DROP POLICY IF EXISTS "League owners can delete their leagues" ON leagues;

-- Create new policies
CREATE POLICY "Users can read leagues they belong to" ON leagues
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = leagues.id
            AND lm.user_id = auth.uid()
        )
        OR owner_id = auth.uid()
        OR creator_id = auth.uid()
    );

CREATE POLICY "Users can create leagues" ON leagues
    FOR INSERT
    WITH CHECK (owner_id = auth.uid() OR creator_id = auth.uid());

CREATE POLICY "League owners can update their leagues" ON leagues
    FOR UPDATE
    USING (owner_id = auth.uid() OR creator_id = auth.uid())
    WITH CHECK (owner_id = auth.uid() OR creator_id = auth.uid());

CREATE POLICY "League owners can delete their leagues" ON leagues
    FOR DELETE
    USING (owner_id = auth.uid() OR creator_id = auth.uid());

-- ==============================================
-- LEAGUE_MEMBERS TABLE
-- ==============================================

-- Drop existing policies
DROP POLICY IF EXISTS "Users can read league members for leagues they belong to" ON league_members;
DROP POLICY IF EXISTS "League owners can add members" ON league_members;
DROP POLICY IF EXISTS "Users can join leagues" ON league_members;
DROP POLICY IF EXISTS "League owners can remove members" ON league_members;
DROP POLICY IF EXISTS "Users can leave leagues" ON league_members;

-- Create new policies
CREATE POLICY "Users can read league members for leagues they belong to" ON league_members
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM league_members lm2
            WHERE lm2.league_id = league_members.league_id
            AND lm2.user_id = auth.uid()
        )
        OR EXISTS (
            SELECT 1 FROM leagues l
            WHERE l.id = league_members.league_id
            AND (l.owner_id = auth.uid() OR l.creator_id = auth.uid())
        )
    );

CREATE POLICY "League owners can add members" ON league_members
    FOR INSERT
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM leagues l
            WHERE l.id = league_members.league_id
            AND (l.owner_id = auth.uid() OR l.creator_id = auth.uid())
        )
    );

CREATE POLICY "Users can join leagues" ON league_members
    FOR INSERT
    WITH CHECK (user_id = auth.uid());

CREATE POLICY "League owners can remove members" ON league_members
    FOR DELETE
    USING (
        EXISTS (
            SELECT 1 FROM leagues l
            WHERE l.id = league_members.league_id
            AND (l.owner_id = auth.uid() OR l.creator_id = auth.uid())
        )
    );

CREATE POLICY "Users can leave leagues" ON league_members
    FOR DELETE
    USING (user_id = auth.uid());

-- ==============================================
-- PICKS TABLE
-- ==============================================

-- Drop existing policies
DROP POLICY IF EXISTS "Users can read picks for leagues they belong to" ON picks;
DROP POLICY IF EXISTS "Users can create picks for leagues they belong to" ON picks;
DROP POLICY IF EXISTS "Users can update their own picks" ON picks;
DROP POLICY IF EXISTS "Users can delete their own picks" ON picks;

-- Create new policies
CREATE POLICY "Users can read picks for leagues they belong to" ON picks
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = picks.league_id
            AND lm.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can create picks for leagues they belong to" ON picks
    FOR INSERT
    WITH CHECK (
        user_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = picks.league_id
            AND lm.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can update their own picks" ON picks
    FOR UPDATE
    USING (
        user_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = picks.league_id
            AND lm.user_id = auth.uid()
        )
    )
    WITH CHECK (
        user_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = picks.league_id
            AND lm.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can delete their own picks" ON picks
    FOR DELETE
    USING (
        user_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM league_members lm
            WHERE lm.league_id = picks.league_id
            AND lm.user_id = auth.uid()
        )
    );

-- ==============================================
-- USER_PROFILES TABLE
-- ==============================================

-- Drop existing policies
DROP POLICY IF EXISTS "Users can read their own profile" ON user_profiles;
DROP POLICY IF EXISTS "Users can create their own profile" ON user_profiles;
DROP POLICY IF EXISTS "Users can update their own profile" ON user_profiles;
DROP POLICY IF EXISTS "Users can delete their own profile" ON user_profiles;

-- Create new policies
CREATE POLICY "Users can read their own profile" ON user_profiles
    FOR SELECT
    USING (user_id = auth.uid());

CREATE POLICY "Users can create their own profile" ON user_profiles
    FOR INSERT
    WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own profile" ON user_profiles
    FOR UPDATE
    USING (user_id = auth.uid())
    WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can delete their own profile" ON user_profiles
    FOR DELETE
    USING (user_id = auth.uid());

-- ==============================================
-- LEAGUE_INVITATIONS TABLE
-- ==============================================

-- Drop existing policies
DROP POLICY IF EXISTS "Users can read invitations they sent or received" ON league_invitations;
DROP POLICY IF EXISTS "League owners can create invitations" ON league_invitations;
DROP POLICY IF EXISTS "Users can update invitations they received" ON league_invitations;
DROP POLICY IF EXISTS "League owners can delete invitations" ON league_invitations;

-- Create new policies
CREATE POLICY "Users can read invitations they sent or received" ON league_invitations
    FOR SELECT
    USING (
        invited_by_user_id = auth.uid()
        OR invited_user_id = auth.uid()
    );

CREATE POLICY "League owners can create invitations" ON league_invitations
    FOR INSERT
    WITH CHECK (
        invited_by_user_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM leagues l
            WHERE l.id = league_invitations.league_id
            AND (l.owner_id = auth.uid() OR l.creator_id = auth.uid())
        )
    );

CREATE POLICY "Users can update invitations they received" ON league_invitations
    FOR UPDATE
    USING (invited_user_id = auth.uid())
    WITH CHECK (invited_user_id = auth.uid());

CREATE POLICY "League owners can delete invitations" ON league_invitations
    FOR DELETE
    USING (
        invited_by_user_id = auth.uid()
        OR EXISTS (
            SELECT 1 FROM leagues l
            WHERE l.id = league_invitations.league_id
            AND (l.owner_id = auth.uid() OR l.creator_id = auth.uid())
        )
    );

-- ==============================================
-- NEWS_ARTICLES TABLE
-- ==============================================

-- Drop existing policies
DROP POLICY IF EXISTS "Anyone can read news articles" ON news_articles;
DROP POLICY IF EXISTS "Admins can manage news articles" ON news_articles;

-- Create new policies
CREATE POLICY "Anyone can read news articles" ON news_articles
    FOR SELECT
    USING (true);

-- Note: For news_articles, you might want to restrict INSERT/UPDATE/DELETE to admin users
-- This would require an admin role or is_admin field in user_profiles
CREATE POLICY "Admins can manage news articles" ON news_articles
    FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM user_profiles up
            WHERE up.user_id = auth.uid()
            AND up.is_admin = true
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM user_profiles up
            WHERE up.user_id = auth.uid()
            AND up.is_admin = true
        )
    );

-- ==============================================
-- ENABLE RLS ON ALL TABLES
-- ==============================================

ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE leagues ENABLE ROW LEVEL SECURITY;
ALTER TABLE league_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE picks ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE league_invitations ENABLE ROW LEVEL SECURITY;
ALTER TABLE news_articles ENABLE ROW LEVEL SECURITY;

-- ==============================================
-- VERIFY POLICIES
-- ==============================================

-- Show all policies for verification
SELECT 
    schemaname, 
    tablename, 
    policyname, 
    permissive, 
    roles, 
    cmd, 
    qual, 
    with_check
FROM pg_policies 
WHERE schemaname = 'public'
ORDER BY tablename, policyname;

