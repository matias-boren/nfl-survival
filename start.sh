#!/bin/bash
set -e

echo "Starting NFL Survival Backend from root directory..."

# Change to backend directory
cd backend

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm ci --only=production
fi

# Start the application
echo "Starting server..."
npm start
