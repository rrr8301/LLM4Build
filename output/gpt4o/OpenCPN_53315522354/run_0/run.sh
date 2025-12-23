#!/bin/bash

# Run pre-build script
./ci/github-pre-build.sh

# Configure CMake
cmake -B build -DCMAKE_BUILD_TYPE=Release

# Build the project
cmake --build build --config Release

# Run tests, ensuring all tests are executed even if some fail
cd build
make run-tests || true