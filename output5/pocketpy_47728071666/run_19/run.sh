#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Navigate to the test directory
cd include/pybind11/tests

# Ensure all dependencies are fetched and built
# This assumes your CMakeLists.txt is set up to handle FetchContent or ExternalProject
# Make sure the URLs in CMakeLists.txt are correct and accessible
echo "Configuring the project with CMake..."
cmake -B build || {
    echo "CMake configuration failed. Please check the URLs in CMakeLists.txt."
    exit 1
}

# Build the project
echo "Building the project..."
cmake --build build --config Release --parallel || {
    echo "Build failed. Please check the build logs for more details."
    exit 1
}

# Run the tests
# Ensure all tests are executed, even if some fail
set +e
echo "Running tests..."
if [ -f "./build/PKBIND_TEST" ]; then
    ./build/PKBIND_TEST
    EXIT_CODE=$?
else
    echo "Test executable not found. Please check the build output."
    EXIT_CODE=1
fi

# Exit with the test's exit code
exit $EXIT_CODE