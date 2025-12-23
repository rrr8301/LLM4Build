#!/bin/bash

set -e
set -o pipefail

# Build the project
cmake -S . -B build -D MZ_BUILD_TESTS=ON
cmake --build build

# Run tests
# Ensure all tests are executed, even if some fail
set +e
ctest --test-dir build --output-on-failure
set -e