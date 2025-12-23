#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
mkdir -p build
cd build
cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
make

# Run tests (if any)
# Placeholder for running tests, ensure all tests run even if some fail
# Example: ctest --output-on-failure || true

# Note: Add actual test commands if available