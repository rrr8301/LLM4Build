#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Navigate to the test directory
cd include/pybind11/tests

# Build the project using CMake
cmake -B build
cmake --build build --config Release --parallel

# Run the tests
# Ensure all tests are executed, even if some fail
set +e
./build/PKBIND_TEST
EXIT_CODE=$?

# Exit with the test's exit code
exit $EXIT_CODE