#!/bin/bash

set -e

# Activate Python environment (if any)
# Assuming no virtual environment is specified, using system Python

# Install project dependencies
# Assuming no specific dependencies are mentioned, skipping pip install

# Compile and run tests
set +e  # Ensure all tests run even if some fail
cd test

# Compile C++ test files
for test_file in *.cpp; do
    # Ensure the include path is set correctly
    # Adjust the path to where 2sat.h is located
    g++ -o "${test_file%.cpp}" "$test_file" -I.. -I../include -I/app -I/app/include -I/app/test -I/app/src -I/app/headers || { echo "Compilation failed for $test_file"; exit 1; }
done

# Run compiled test binaries
for test_binary in test_*; do
    if [ -x "$test_binary" ]; then
        ./"$test_binary"
        if [ $? -ne 0 ]; then
            echo "$test_binary failed!"
        fi
    fi
done

# Check if test.sh exists and run it
if [ -f ./test.sh ]; then
    ./test.sh
else
    echo "Error: test.sh not found in the test directory."
    exit 1
fi