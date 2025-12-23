#!/bin/bash

# Activate environments if any (none specified)

# Install project dependencies if any (none specified)

# Build fuzzers
echo "Building fuzzers..."
cmake -Bbuild -H. -DCMAKE_BUILD_TYPE=Release
cmake --build build

# Run fuzzers
echo "Running fuzzers..."
# Assuming fuzzers are built in the build directory
# Replace 'fuzzer_target' with actual fuzzer executable names
for fuzzer in build/fuzzer_target*; do
    if [[ -x "$fuzzer" ]]; then
        "$fuzzer" -max_total_time=300 || true
    fi
done

# Ensure all test cases are executed, even if some fail
echo "Fuzzing completed."