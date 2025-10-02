#!/bin/bash

# Pick1 News Service - Railway Deployment Script
echo "🚀 Deploying Pick1 News Service to Railway..."

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI not found. Installing..."
    npm install -g @railway/cli
fi

# Check if we're logged in to Railway
if ! railway whoami &> /dev/null; then
    echo "🔑 Please log in to Railway..."
    railway login
fi

# Create new project if it doesn't exist
echo "📦 Setting up Railway project..."
railway project create pick1-news-service || echo "Project may already exist"

# Deploy the service
echo "🚀 Deploying service..."
railway up

echo "⚙️ Setting environment variables..."
echo "Please set these variables in Railway dashboard or via CLI:"
echo "- SUPABASE_URL"
echo "- SUPABASE_ANON_KEY" 
echo "- OPENAI_API_KEY"
echo "- NODE_ENV=production"
echo "- RUN_ON_STARTUP=true"

echo ""
echo "🔧 To set variables via CLI:"
echo "railway variables set SUPABASE_URL=your_url"
echo "railway variables set SUPABASE_ANON_KEY=your_key"
echo "railway variables set OPENAI_API_KEY=your_key"
echo "railway variables set NODE_ENV=production"
echo "railway variables set RUN_ON_STARTUP=true"

echo ""
echo "✅ Deployment script completed!"
echo "🌐 Check Railway dashboard for your service URL"
echo "🔍 Test with: curl https://your-service-url.railway.app/health"
