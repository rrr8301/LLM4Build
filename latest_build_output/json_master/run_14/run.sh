#!/bin/bash

# Activate environments if needed (none specified)

# Install project dependencies if needed (none specified)

# Build Fuzzers
echo "Building fuzzers..."
# Assuming a build script or CMakeLists.txt is present
cmake -S . -B build -DCMAKE_CXX_FLAGS="-march=native -mpopcnt"
cmake --build build

# Identify the correct fuzzer executable
# Adjust the search pattern if the executable has a different name
FUZZER_EXECUTABLE=$(find ./build -type f -executable -name '*fuzzer*' | head -n 1)

# Check if the fuzzer executable exists
if [ -z "$FUZZER_EXECUTABLE" ]; then
    echo "Error: Fuzzer executable not found in ./build directory."
    echo "Attempting to build fuzzers using alternative methods..."

    # Attempt to build using alternative methods if available
    if [ -f "tests/thirdparty/Fuzzer/build.sh" ]; then
        echo "Running alternative build script for fuzzers..."
        # Ensure the build script uses the correct flags
        CXXFLAGS="-march=native -mpopcnt" bash tests/thirdparty/Fuzzer/build.sh
        FUZZER_EXECUTABLE=$(find ./build -type f -executable -name '*fuzzer*' | head -n 1)
    fi

    # Re-check if the fuzzer executable exists
    if [ -z "$FUZZER_EXECUTABLE" ]; then
        echo "Error: Fuzzer executable still not found after alternative build attempts."
        exit 1
    fi
fi

# Run Fuzzers
echo "Running fuzzers..."
# Use the identified fuzzer executable
"$FUZZER_EXECUTABLE" --fuzz-seconds=300

# Ensure all test cases are executed
echo "All fuzzing tests executed."