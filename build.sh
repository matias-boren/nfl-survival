#!/bin/bash
set -e

echo "🚀 Building Flutter web app..."

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter not found. Using pre-built files."
    exit 0
fi

# Build the Flutter web app
flutter build web --release

echo "✅ Build completed successfully!"
