#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Navigate to the test directory
cd include/pybind11/tests

# Ensure all dependencies are fetched and built
# This assumes your CMakeLists.txt is set up to handle FetchContent or ExternalProject
# Make sure the URLs in CMakeLists.txt are correct and accessible
cmake -B build

# Check if cmake configuration was successful
if [ $? -ne 0 ]; then
    echo "CMake configuration failed. Please check the URLs in CMakeLists.txt."
    exit 1
fi

cmake --build build --config Release --parallel

# Run the tests
# Ensure all tests are executed, even if some fail
set +e
./build/PKBIND_TEST
EXIT_CODE=$?

# Exit with the test's exit code
exit $EXIT_CODE