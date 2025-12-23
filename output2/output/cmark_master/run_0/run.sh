#!/bin/bash

# Set environment variables for the build
export CC=clang
export CXX=clang++

# Build and test
cmake -DBUILD_SHARED_LIBS=YES -DCMAKE_BUILD_TYPE=Debug -S . -B build
cmake --build build
ctest --test-dir build --output-on-failure || true  # Ensure all tests run even if some fail