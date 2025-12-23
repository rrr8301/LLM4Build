#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project using CMake
cmake -S . -B build
cmake --build build

# Run tests
cd build
ctest --output-on-failure  # Ensure all tests run even if some fail