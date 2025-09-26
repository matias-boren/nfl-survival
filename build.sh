#!/bin/bash

# Install Flutter if not present
if ! command -v flutter &> /dev/null; then
    echo "Installing Flutter..."
    # Add Flutter installation logic here if needed
fi

# Get dependencies
flutter pub get

# Build for web
flutter build web --release

echo "Build completed successfully!"