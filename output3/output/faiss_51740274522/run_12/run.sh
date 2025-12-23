#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Set CUDA toolkit path
export CUDAToolkit_ROOT=/usr/local/cuda

# Ensure CUDA is properly set up
export PATH=/usr/local/cuda/bin:${PATH}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}

# Build the project using CMake
cmake -S . -B build -DCMAKE_INCLUDE_PATH=/app/faiss/perf_tests

# Ensure the include path is correct
cmake -S . -B build -DCMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE=/app/faiss

# Build the project
cmake --build build

# Run tests
cd build
ctest --output-on-failure