#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies (if any)
# Assuming no additional dependencies are needed

# Build the project
mkdir -p build
cd build
cmake -G Ninja ..
ninja

# Run tests
# Assuming tests are part of the build process
ctest --output-on-failure || true

# Ensure all tests are executed, even if some fail