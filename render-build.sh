#!/usr/bin/env bash
# Exit on error
set -o errexit

# Clone Flutter stable channel into a temporary directory if not already cached
if [ ! -d "../flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 ../flutter
fi

# Add Flutter to the path
export PATH="$PATH:`pwd`/../flutter/bin"

# Pre-download development binaries
flutter doctor

# Build the Flutter Web project
flutter build web --release