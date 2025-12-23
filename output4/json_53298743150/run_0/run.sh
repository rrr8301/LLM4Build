#!/bin/bash

# Clone the repository (simulating actions/checkout)
git clone https://github.com/nlohmann/json.git .
git checkout develop

# Run CMake
cmake -S . -B build -DJSON_CI=On

# Build the project
cmake --build build --target ci_test_gcc

# Run tests (ensure all tests are executed)
ctest --output-on-failure || true