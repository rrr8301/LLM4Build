#!/bin/bash

# Verify libnvme version is correct
pkg-config --modversion libnvme || { echo "libnvme not found"; exit 1; }

# Install project dependencies
meson setup .build || { echo "Meson setup failed"; exit 1; }

# Run build script with matrix parameters
./scripts/build.sh -b release -c gcc -x || { echo "Build script failed"; exit 1; }

# Run tests
meson test -C .build --no-rebuild --print-errorlogs || { echo "Tests failed"; exit 1; }

# Ensure all test cases are executed
exit 0