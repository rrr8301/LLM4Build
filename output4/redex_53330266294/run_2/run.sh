#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
mkdir -p build
cd build
cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
make

# Run tests (if any)
# Ensure all tests run even if some fail
# Example: ctest --output-on-failure || true

# Note: Add actual test commands if available
# Example: ./run_tests || true

# If there are specific test commands, they should be added here
# For example, if you have a test suite, you might run:
# ctest --output-on-failure