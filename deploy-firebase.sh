#!/bin/bash

# Firebase Hosting Deployment Script for Flutter Web
echo "🚀 Starting Firebase deployment..."

# Build Flutter web app
echo "📦 Building Flutter web app..."
flutter build web --release

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Flutter build successful"
    
    # Deploy to Firebase (requires firebase CLI and login)
    echo "🔥 Deploying to Firebase Hosting..."
    firebase deploy --only hosting
    
    if [ $? -eq 0 ]; then
        echo "🎉 Deployment successful!"
        echo "Your app is now live on Firebase Hosting"
    else
        echo "❌ Firebase deployment failed"
        echo "Make sure you're logged in: firebase login"
        echo "And have a project initialized: firebase init hosting"
    fi
else
    echo "❌ Flutter build failed"
    exit 1
fi
