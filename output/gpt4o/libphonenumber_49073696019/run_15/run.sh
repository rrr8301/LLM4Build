#!/bin/bash

# Navigate to the build directory
cd /app/cpp/build

# Initialize test counters
total_tests=0
failed_tests=0
test_failures=0

# Function to run tests and count results
run_test() {
    local test_name=$1
    local test_executable=$2
    local xml_output="${test_name}_results.xml"
    
    echo "Starting test: $test_name"
    
    # Check if executable exists
    if [ ! -f "$test_executable" ]; then
        echo "Error: Test executable $test_executable not found"
        test_failures=$((test_failures + 1))
        echo "----------------------------------------"
        return
    fi
    
    # Run the test and capture the exit code
    set +e
    ./$test_executable --gtest_output=xml:$xml_output
    local exit_code=$?
    set -e
    
    if [ $exit_code -eq 0 ]; then
        if [ -f "$xml_output" ]; then
            local tests_run=$(grep -o 'tests="[0-9]*"' "$xml_output" | head -1 | grep -o '[0-9]*')
            local tests_failed=$(grep -o 'failures="[0-9]*"' "$xml_output" | head -1 | grep -o '[0-9]*')
            
            total_tests=$((total_tests + tests_run))
            failed_tests=$((failed_tests + tests_failed))
            
            echo "$test_name completed with $tests_failed failures out of $tests_run tests"
        else
            echo "Warning: XML output not generated for $test_name"
            test_failures=$((test_failures + 1))
        fi
    else
        echo "$test_name failed to run (exit code: $exit_code)"
        test_failures=$((test_failures + 1))
    fi
    
    echo "----------------------------------------"
}

# Run all test executables
run_test "libphonenumber_test" "libphonenumber_test"
run_test "generate_geocoding_data_test" "tools/generate_geocoding_data_test"

# Final results
if [ $failed_tests -ne 0 ] || [ $test_failures -ne 0 ]; then
    echo "TEST FAILURE: $failed_tests test failures and $test_failures test execution failures out of $total_tests tests"
    exit 1
else
    echo "TEST SUCCESS: All $total_tests tests passed"
    exit 0
fi