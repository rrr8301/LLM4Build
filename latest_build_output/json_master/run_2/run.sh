#!/bin/bash

# Activate environments if needed (none specified)

# Install project dependencies if needed (none specified)

# Build Fuzzers
echo "Building fuzzers..."
# Assuming a build script or CMakeLists.txt is present
cmake -S . -B build
cmake --build build

# Identify the correct fuzzer executable
# This assumes the executable is named 'fuzzer_executable' or similar
FUZZER_EXECUTABLE=$(find ./build -type f -executable -name 'fuzzer_executable*' | head -n 1)

# Check if the fuzzer executable exists
if [ -z "$FUZZER_EXECUTABLE" ]; then
    echo "Error: fuzzer_executable not found in ./build directory."
    exit 1
fi

# Run Fuzzers
echo "Running fuzzers..."
# Use the identified fuzzer executable
"$FUZZER_EXECUTABLE" --fuzz-seconds=300

# Ensure all test cases are executed
echo "All fuzzing tests executed."