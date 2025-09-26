-- Test RLS policies for league_members table
-- Run this in your Supabase SQL Editor

-- Check current RLS policies on league_members
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
WHERE tablename = 'league_members';

-- Test if we can query league_members directly
SELECT * FROM league_members LIMIT 5;

-- Test if we can count league_members
SELECT COUNT(*) FROM league_members;

-- Test specific league query
SELECT COUNT(*) 
FROM league_members 
WHERE league_id = 'b2d97471-b3f9-4116-b00b-715eab2faabd';
