#!/bin/bash

# Set environment variables
export CC=clang
export CXX=clang++

# Build the project
cmake -DBUILD_SHARED_LIBS=YES -DCMAKE_BUILD_TYPE=Debug -S . -B build
cmake --build build

# Run tests
ctest --test-dir build --output-on-failure || true