#!/bin/bash

# Navigate to the build directory
cd /app/cpp/build

# Initialize test counters
total_tests=0
failed_tests=0
test_execution_failures=0

# Function to run tests and count results
run_test() {
    local test_name=$1
    local test_executable=$2
    local xml_output="${test_name}_results.xml"
    
    echo "Starting test: $test_name"
    
    # Check if executable exists
    if [ ! -f "$test_executable" ]; then
        echo "Error: Test executable $test_executable not found"
        test_execution_failures=$((test_execution_failures + 1))
        echo "----------------------------------------"
        return 1
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
            
            if [ $tests_failed -eq 0 ]; then
                echo "SUCCESS: $test_name completed with all $tests_run tests passing"
            else
                echo "WARNING: $test_name completed with $tests_failed failures out of $tests_run tests"
            fi
        else
            echo "WARNING: XML output not generated for $test_name"
            test_execution_failures=$((test_execution_failures + 1))
        fi
    else
        echo "ERROR: $test_name failed to run (exit code: $exit_code)"
        test_execution_failures=$((test_execution_failures + 1))
    fi
    
    echo "----------------------------------------"
}

# Run all test executables
run_test "libphonenumber_test" "libphonenumber_test"
run_test "generate_geocoding_data_test" "tools/generate_geocoding_data_test"

# Final results
if [ $failed_tests -ne 0 ] || [ $test_execution_failures -ne 0 ]; then
    echo "TEST SUMMARY:"
    echo "Total tests run: $total_tests"
    echo "Test failures: $failed_tests"
    echo "Test execution failures: $test_execution_failures"
    echo "OVERALL RESULT: FAILURE"
    exit 1
else
    echo "TEST SUMMARY:"
    echo "Total tests run: $total_tests"
    echo "Test failures: 0"
    echo "Test execution failures: 0"
    echo "OVERALL RESULT: SUCCESS"
    exit 0
fi