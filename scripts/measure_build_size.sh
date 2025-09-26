#!/bin/bash

echo "=== Build Size Analysis ==="

# Clean previous builds
flutter clean
flutter pub get

# Build release APK
echo "Building release APK..."
flutter build apk --release --analyze-size > apk_size_before.txt 2>&1

# Extract size information
APK_SIZE=$(grep "APK size" apk_size_before.txt | grep -o '[0-9]*\.[0-9]* MB' | head -1)
echo "APK Size: $APK_SIZE"

# Build release AAB
echo "Building release AAB..."
flutter build appbundle --release --analyze-size > aab_size_before.txt 2>&1

AAB_SIZE=$(grep "AAB size" aab_size_before.txt | grep -o '[0-9]*\.[0-9]* MB' | head -1)
echo "AAB Size: $AAB_SIZE"

# Save baseline measurements
echo "APK_SIZE_BEFORE=$APK_SIZE" > measurements_baseline.env
echo "AAB_SIZE_BEFORE=$AAB_SIZE" >> measurements_baseline.env

echo "Baseline measurements saved to measurements_baseline.env"
