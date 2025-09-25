#!/bin/bash
set -e

echo "Starting NFL Survival Backend..."

# Change to backend directory if we're in the root
if [ -d "backend" ]; then
    echo "Changing to backend directory..."
    cd backend
fi

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm ci --only=production
fi

# Start the application
echo "Starting server..."
npm start
