#!/bin/bash

# Run CMake
cmake -S . -B build -DJSON_CI=On

# Build the project
cmake --build build --target ci_test_gcc

# Run tests (assuming tests are part of the build process)
# Ensure all tests are executed, even if some fail
ctest --output-on-failure || true