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
test_count=0

# Find and run all test executables
for test_executable in $(find . -type f -executable -name "*_test" -o -name "*_test*"); do
    echo "Running test: $test_executable"
    $test_executable
    result=$?
    test_count=$((test_count + 1))
    if [ $result -ne 0 ]; then
        test_failures=$((test_failures + 1))
    fi
    echo "----------------------------------------"
done

# Check if any tests were found and run
if [ $test_count -eq 0 ]; then
    echo "Error: No tests were found to run"
    exit 1
fi

# Check if any tests failed
if [ $test_failures -ne 0 ]; then
    echo "$test_failures tests failed out of $test_count"
    exit 1
else
    echo "All $test_count tests passed successfully"
    exit 0
fi