#!/bin/bash
set -e

echo "Starting NFL Survival Backend..."

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install --only=production
fi

# Start the application
echo "Starting server..."
npm start
