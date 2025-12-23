#!/bin/bash

set -e

# Install project dependencies (if any)

# Generate project files using CMake
cmake -S . -B build -D MZ_BUILD_TESTS=ON -D MZ_BUILD_UNIT_TESTS=ON -D BUILD_SHARED_LIBS=OFF -D CMAKE_BUILD_TYPE=Release

# Compile the source code
cmake --build build --config Release

# Run test cases, ensuring all are executed even if some fail
set +e
ctest --output-on-failure -C Release --test-dir build