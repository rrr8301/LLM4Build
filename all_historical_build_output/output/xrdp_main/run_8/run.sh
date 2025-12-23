#!/bin/bash

set -e

# Compile and install xrdp
./bootstrap
./configure
make

# Run tests
# Check if CTest is available and use it if possible
if [ -f CMakeLists.txt ]; then
    mkdir -p build
    cd build
    cmake ..
    make # Ensure all targets are built
    ctest --output-on-failure
else
    # Fallback to running a custom test script if available
    if [ -f run_tests.sh ]; then
        ./run_tests.sh
    else
        echo "No test target or test script found."
        exit 1
    fi
fi