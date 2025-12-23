#!/bin/bash

# Navigate to the C++ directory
cd cpp

# Create and navigate to the build directory
mkdir -p build
cd build

# Set Abseil path
export CMAKE_PREFIX_PATH=/usr/local/lib/cmake/absl

# Build the project with retry in case of network issues
set +e
for i in {1..3}; do
    cmake -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_PREFIX_PATH=/usr/local/lib/cmake/absl .. && break
    if [ $i -eq 3 ]; then
        echo "CMake failed after 3 attempts"
        exit 1
    fi
    echo "CMake failed, retrying..."
    sleep 5
done

# Build the project
make -j$(nproc)

# Run all tests found in the build directory
set +e  # Continue executing even if some tests fail
test_failures=0
for test_executable in $(find . -type f -executable -name "*_test"); do
    echo "Running test: $test_executable"
    $test_executable
    if [ $? -ne 0 ]; then
        test_failures=$((test_failures + 1))
    fi
    echo "----------------------------------------"
done

# Check if any tests failed
if [ $test_failures -ne 0 ]; then
    echo "$test_failures tests failed"
    exit 1
else
    echo "All tests passed successfully"
    exit 0
fi