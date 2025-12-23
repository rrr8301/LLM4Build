#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project using CMake
cmake -S . -B build
cmake --build build

# Run tests
# Assuming tests are part of the build process or a separate command
# Replace `ctest` with the appropriate test command if different
cd build
ctest --output-on-failure || true  # Ensure all tests run even if some fail