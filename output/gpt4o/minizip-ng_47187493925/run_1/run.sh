#!/bin/bash

# Set up environment variables if needed
export CC=clang-11
export CXX=clang++-11

# Generate project files with all required dependencies
cmake -S . -B build -D MZ_BUILD_TESTS=ON -D MZ_BUILD_UNIT_TESTS=ON \
    -D BUILD_SHARED_LIBS=OFF -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_C_COMPILER=clang-11 -D CMAKE_CXX_COMPILER=clang++-11

# Compile source code
cmake --build build --config Release --target all

# Run test cases with verbose output
cd build && ctest --output-on-failure -C Release -V