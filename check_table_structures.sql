-- Check the actual structure of all tables to fix RLS policies
-- This will help us identify the correct column names

-- Check leagues table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'leagues' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check league_members table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'league_members' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check league_invitations table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'league_invitations' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check chat_messages table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'chat_messages' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check picks table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'picks' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check user_profiles table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'user_profiles' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check news_articles table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'news_articles' 
AND table_schema = 'public'
ORDER BY ordinal_position;

