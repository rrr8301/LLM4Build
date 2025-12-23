#!/bin/bash

set -e

# Build the project
mkdir -p build
cd build
cmake -G Ninja ..
ninja

# Run tests
# Assuming tests are run using CTest or a similar framework
set +e  # Ensure all tests run even if some fail
ctest --output-on-failure