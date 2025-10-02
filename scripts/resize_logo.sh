#!/bin/bash

# Logo Resize Script for Pick1
# This script creates all required logo sizes from a source image

SOURCE_LOGO="assets/images/logo/pick1_logo_source.png"
LOGO_DIR="assets/images/logo"
ICON_DIR="assets/images/icons"

echo "🎨 Pick1 Logo Resize Script"
echo "================================"

# Check if source logo exists
if [ ! -f "$SOURCE_LOGO" ]; then
    echo "❌ Source logo not found: $SOURCE_LOGO"
    echo "Please save your 1600x896px logo as: $SOURCE_LOGO"
    exit 1
fi

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "❌ ImageMagick not found. Installing via Homebrew..."
    if command -v brew &> /dev/null; then
        brew install imagemagick
    else
        echo "Please install ImageMagick: brew install imagemagick"
        exit 1
    fi
fi

echo "✅ Source logo found: $SOURCE_LOGO"
echo "📏 Creating horizontal logo variants..."

# Horizontal logos (maintaining aspect ratio ~16:9)
convert "$SOURCE_LOGO" -resize 400x120 "$LOGO_DIR/pick1_logo_horizontal.png"
convert "$SOURCE_LOGO" -resize 800x240 "$LOGO_DIR/pick1_logo_horizontal@2x.png"
convert "$SOURCE_LOGO" -resize 1200x360 "$LOGO_DIR/pick1_logo_horizontal@3x.png"

echo "✅ Horizontal logos created"

# White versions (for dark backgrounds) - invert colors
echo "🎨 Creating white logo variants..."
convert "$SOURCE_LOGO" -resize 400x120 -negate "$LOGO_DIR/pick1_logo_white.png"
convert "$SOURCE_LOGO" -resize 800x240 -negate "$LOGO_DIR/pick1_logo_white@2x.png"
convert "$SOURCE_LOGO" -resize 1200x360 -negate "$LOGO_DIR/pick1_logo_white@3x.png"

echo "✅ White logo variants created"

# Square versions (crop to center square)
echo "📐 Creating square logo variants..."
convert "$SOURCE_LOGO" -resize 400x400^ -gravity center -extent 400x400 "$LOGO_DIR/pick1_logo_square.png"
convert "$SOURCE_LOGO" -resize 800x800^ -gravity center -extent 800x800 "$LOGO_DIR/pick1_logo_square@2x.png"
convert "$SOURCE_LOGO" -resize 1200x1200^ -gravity center -extent 1200x1200 "$LOGO_DIR/pick1_logo_square@3x.png"

echo "✅ Square logos created"

# Small icons
echo "🔸 Creating icon variants..."
convert "$SOURCE_LOGO" -resize 64x64^ -gravity center -extent 64x64 "$ICON_DIR/pick1_icon.png"
convert "$SOURCE_LOGO" -resize 128x128^ -gravity center -extent 128x128 "$ICON_DIR/pick1_icon@2x.png"
convert "$SOURCE_LOGO" -resize 192x192^ -gravity center -extent 192x192 "$ICON_DIR/pick1_icon@3x.png"

echo "✅ Icons created"

# Web favicon
echo "🌐 Creating web favicon..."
convert "$SOURCE_LOGO" -resize 32x32^ -gravity center -extent 32x32 "web/favicon.png"

echo ""
echo "🎉 All logo variants created successfully!"
echo ""
echo "📁 Generated files:"
echo "   Horizontal: pick1_logo_horizontal.png (+ @2x, @3x)"
echo "   White: pick1_logo_white.png (+ @2x, @3x)"
echo "   Square: pick1_logo_square.png (+ @2x, @3x)"
echo "   Icons: pick1_icon.png (+ @2x, @3x)"
echo "   Favicon: web/favicon.png"
echo ""
echo "🚀 Ready to test in your app!"
