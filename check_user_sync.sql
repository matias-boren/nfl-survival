-- Check synchronization between auth.users and user_profiles tables

-- Count users in each table
SELECT 
    'auth.users' as table_name,
    COUNT(*) as user_count
FROM auth.users
WHERE email_confirmed_at IS NOT NULL

UNION ALL

SELECT 
    'user_profiles' as table_name,
    COUNT(*) as user_count
FROM user_profiles;

-- Show users in auth but not in user_profiles
SELECT 
    'Missing in user_profiles' as status,
    au.id,
    au.email,
    au.raw_user_meta_data->>'full_name' as display_name,
    au.email_confirmed_at
FROM auth.users au
LEFT JOIN user_profiles up ON au.id = up.user_id
WHERE up.user_id IS NULL
AND au.email_confirmed_at IS NOT NULL;

-- Show users in user_profiles but not in auth (shouldn't happen)
SELECT 
    'Missing in auth.users' as status,
    up.user_id,
    up.display_name
FROM user_profiles up
LEFT JOIN auth.users au ON up.user_id = au.id
WHERE au.id IS NULL;
