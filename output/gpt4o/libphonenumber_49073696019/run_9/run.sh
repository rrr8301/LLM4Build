#!/bin/bash

# Navigate to the build directory
cd /app/cpp/build

# Run the main test executable
echo "Running main test executable: libphonenumber_test"
./libphonenumber_test
test_result=$?
test_count=1
test_failures=0

if [ $test_result -ne 0 ]; then
    test_failures=$((test_failures + 1))
fi
echo "----------------------------------------"

# Run the geocoding data test executable
echo "Running geocoding data test: generate_geocoding_data_test"
./tools/generate_geocoding_data_test
result=$?
test_count=$((test_count + 1))
if [ $result -ne 0 ]; then
    test_failures=$((test_failures + 1))
fi
echo "----------------------------------------"

# Check if any tests failed
if [ $test_failures -ne 0 ]; then
    echo "$test_failures tests failed out of $test_count"
    exit 1
else
    echo "All $test_count tests passed successfully"
    exit 0
fi