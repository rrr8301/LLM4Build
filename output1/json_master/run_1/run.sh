#!/bin/bash

# Activate environments if needed (none specified)

# Install project dependencies if needed (none specified)

# Build Fuzzers
echo "Building fuzzers..."
# Assuming a build script or CMakeLists.txt is present
cmake -S . -B build
cmake --build build

# Check if the fuzzer executable exists
if [ ! -f ./build/fuzzer_executable ]; then
    echo "Error: fuzzer_executable not found in ./build directory."
    exit 1
fi

# Run Fuzzers
echo "Running fuzzers..."
# Replace 'fuzzer_executable' with the actual executable name
./build/fuzzer_executable --fuzz-seconds=300

# Ensure all test cases are executed
echo "All fuzzing tests executed."