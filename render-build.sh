#!/usr/bin/env bash
# Exit on error
set -o errexit

FLUTTER_DIR="$HOME/flutter"

# Clone Flutter stable channel if not present
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "Cloning Flutter SDK..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_DIR"
fi

# Add Flutter to PATH
export PATH="$FLUTTER_DIR/bin:$PATH"

echo "Checking Flutter version..."
flutter --version

echo "Building Flutter Web..."
flutter build web --release