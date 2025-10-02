#!/bin/bash

# Logo Cleanup Script for Pick1
# This script removes all generated logo files, keeping only the source

LOGO_DIR="assets/images/logo"
ICON_DIR="assets/images/icons"
SOURCE_LOGO="assets/images/logo/pick1_logo_source.png"

echo "🧹 Pick1 Logo Cleanup Script"
echo "================================"

# Check if source logo exists
if [ ! -f "$SOURCE_LOGO" ]; then
    echo "⚠️  Warning: Source logo not found: $SOURCE_LOGO"
    echo "Make sure to keep your original logo file!"
fi

echo "🗑️  Removing generated logo files..."

# Remove horizontal logos
rm -f "$LOGO_DIR/pick1_logo_horizontal.png"
rm -f "$LOGO_DIR/pick1_logo_horizontal@2x.png"
rm -f "$LOGO_DIR/pick1_logo_horizontal@3x.png"
echo "✅ Removed horizontal logos"

# Remove white logos
rm -f "$LOGO_DIR/pick1_logo_white.png"
rm -f "$LOGO_DIR/pick1_logo_white@2x.png"
rm -f "$LOGO_DIR/pick1_logo_white@3x.png"
echo "✅ Removed white logo variants"

# Remove square logos
rm -f "$LOGO_DIR/pick1_logo_square.png"
rm -f "$LOGO_DIR/pick1_logo_square@2x.png"
rm -f "$LOGO_DIR/pick1_logo_square@3x.png"
echo "✅ Removed square logos"

# Remove icons
rm -f "$ICON_DIR/pick1_icon.png"
rm -f "$ICON_DIR/pick1_icon@2x.png"
rm -f "$ICON_DIR/pick1_icon@3x.png"
echo "✅ Removed icons"

# Remove web favicon
rm -f "web/favicon.png"
echo "✅ Removed web favicon"

echo ""
echo "🎯 Cleanup complete!"
echo ""
echo "📁 Remaining files:"
if [ -f "$SOURCE_LOGO" ]; then
    echo "   ✅ $SOURCE_LOGO (preserved)"
else
    echo "   ❌ Source logo not found!"
fi

echo ""
echo "💡 Next steps:"
echo "   1. Edit your source logo: $SOURCE_LOGO"
echo "   2. Run: ./scripts/resize_logo.sh (to regenerate all sizes)"
echo ""
