#!/bin/bash

# Navigate to the build directory
cd /app/cpp/build

# Initialize test counters
total_tests=0
failed_tests=0

# Function to count tests from XML output
count_tests() {
    local xml_file=$1
    local tests=$(grep -o 'tests="[0-9]*"' "$xml_file" | head -1 | grep -o '[0-9]*')
    local failures=$(grep -o 'failures="[0-9]*"' "$xml_file" | head -1 | grep -o '[0-9]*')
    echo "$tests $failures"
}

# Run the main test executable
echo "Running main test executable: libphonenumber_test"
if ./libphonenumber_test --gtest_output=xml:libphonenumber_test_results.xml; then
    read tests_run tests_failed <<< $(count_tests libphonenumber_test_results.xml)
    total_tests=$((total_tests + tests_run))
    failed_tests=$((failed_tests + tests_failed))
    echo "libphonenumber_test completed with $tests_failed failures out of $tests_run tests"
else
    echo "libphonenumber_test failed to run"
    exit 1
fi
echo "----------------------------------------"

# Run the geocoding data test executable
echo "Running geocoding data test: generate_geocoding_data_test"
if ./tools/generate_geocoding_data_test --gtest_output=xml:geocoding_test_results.xml; then
    read tests_run tests_failed <<< $(count_tests geocoding_test_results.xml)
    total_tests=$((total_tests + tests_run))
    failed_tests=$((failed_tests + tests_failed))
    echo "generate_geocoding_data_test completed with $tests_failed failures out of $tests_run tests"
else
    echo "generate_geocoding_data_test failed to run"
    exit 1
fi
echo "----------------------------------------"

# Final results
if [ $failed_tests -ne 0 ]; then
    echo "TEST FAILURE: $failed_tests tests failed out of $total_tests"
    exit 1
else
    echo "TEST SUCCESS: All $total_tests tests passed"
    exit 0
fi