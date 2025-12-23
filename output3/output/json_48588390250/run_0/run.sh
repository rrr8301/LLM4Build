#!/bin/bash

# Run CMake
cmake -S . -B build -DJSON_CI=On

# Build the project
cmake --build build --target ci_test_gcc

# Run tests
# Assuming tests are part of the build process or need to be run separately
# If tests are separate, add the command to run them here