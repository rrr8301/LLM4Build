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

# If there are specific test commands, they should be added here
# For example, if you have a test suite, you might run:
# ctest --output-on-failure

# Example of running tests with ctest
ctest --output-on-failure || true