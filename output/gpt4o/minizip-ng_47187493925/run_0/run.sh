#!/bin/bash

# Activate environment variables if needed (none in this case)

# Install project dependencies (none specified beyond system packages)

# Generate project files
cmake -S . -B build -D MZ_BUILD_TESTS=ON -D MZ_BUILD_UNIT_TESTS=ON -D BUILD_SHARED_LIBS=OFF -D CMAKE_BUILD_TYPE=Release

# Compile source code
cmake --build build --config Release

# Run test cases
ctest --output-on-failure -C Release --test-dir build || true

# Ensure all test cases are executed, even if some fail