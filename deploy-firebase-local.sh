#!/bin/bash

# Firebase Hosting Deployment Script
echo "🚀 Starting Firebase deployment..."

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI not found. Please install it first:"
    echo "npm install -g firebase-tools"
    exit 1
fi

# Check if user is logged in
if ! firebase projects:list &> /dev/null; then
    echo "❌ Not logged in to Firebase. Please run:"
    echo "firebase login"
    exit 1
fi

# Build Flutter web app
echo "📦 Building Flutter web app..."
flutter build web --release

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Flutter build successful"
    
    # Initialize Firebase if not already done
    if [ ! -f "firebase.json" ]; then
        echo "🔧 Initializing Firebase..."
        firebase init hosting --project pick1-34708 --public build/web --yes
    fi
    
    # Deploy to Firebase
    echo "🔥 Deploying to Firebase Hosting..."
    firebase deploy --project pick1-34708
    
    if [ $? -eq 0 ]; then
        echo "🎉 Deployment successful!"
        echo "Your app is now live on Firebase Hosting"
        echo "Visit: https://pick1-34708.web.app"
    else
        echo "❌ Firebase deployment failed"
    fi
else
    echo "❌ Flutter build failed"
    exit 1
fi
