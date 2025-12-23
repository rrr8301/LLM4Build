#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Set CUDA toolkit path
export CUDAToolkit_ROOT=/usr/local/cuda

# Build the project using CMake
cmake -S . -B build
cmake --build build

# Run tests
cd build
ctest --output-on-failure