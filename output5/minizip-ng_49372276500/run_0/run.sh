# run.sh
#!/bin/bash

set -e

# Set environment variables for compilers
export CC=clang-11
export CXX=clang++-11

# Generate project files
cmake -S . -B build -D MZ_BUILD_TESTS=ON -D MZ_BUILD_UNIT_TESTS=ON -D BUILD_SHARED_LIBS=OFF -D CMAKE_BUILD_TYPE=Release

# Compile source code
cmake --build build --config Release

# Run test cases
# Ensure all tests are executed, even if some fail
ctest --output-on-failure -C Release || true