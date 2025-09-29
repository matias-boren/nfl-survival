# Security Information

## Public Repository Security

This repository is public and contains an NFL Survival Pool application. Here's what you need to know about security:

### ✅ Safe to be Public

- **Firebase API Keys**: Client-side keys designed to be public
- **Supabase Anon Key**: Client-side key designed to be public
- **App Source Code**: No sensitive business logic exposed
- **Database**: Protected by Row Level Security (RLS) policies

### 🔒 Security Measures

1. **Database Security**: All data access is controlled by Supabase RLS policies
2. **Authentication**: Handled by Supabase Auth with proper session management
3. **API Keys**: Only client-side keys are exposed (server-side keys are in GitHub Secrets)
4. **Environment Variables**: Sensitive values are injected at build time

### 🚫 What's NOT Exposed

- Server-side API keys
- Database passwords
- Admin credentials
- Private user data (protected by RLS)

### 🔧 For Developers

1. Copy `env.example` to `.env` and fill in your values
2. Set up GitHub Secrets for CI/CD:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
   - `FIREBASE_SERVICE_ACCOUNT_NFL_SURVIVAL`

### 📞 Security Issues

If you find a security vulnerability, please report it privately to the maintainers.
