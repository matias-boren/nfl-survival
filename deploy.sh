#!/bin/bash
set -e

echo "🚀 Building Flutter web app for production..."

# Build the Flutter web app
flutter build web --release

echo "✅ Build completed successfully!"
echo "📁 Build output: build/web/"
echo ""
echo "🌐 Ready for deployment to Netlify!"
echo ""
echo "Next steps:"
echo "1. Go to https://netlify.com"
echo "2. Sign up/login with GitHub"
echo "3. Click 'New site from Git'"
echo "4. Connect your GitHub repository"
echo "5. Set build command: flutter build web --release"
echo "6. Set publish directory: build/web"
echo "7. Deploy!"
