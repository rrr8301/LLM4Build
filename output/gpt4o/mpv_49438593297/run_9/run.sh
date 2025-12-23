#!/bin/bash

# Set compiler and linker
export CC=gcc
export CXX=g++
export CC_LD=lld
export CXX_LD=lld

# Run tests with LSAN options and verbose output
export LSAN_OPTIONS="suppressions=$(pwd)/.lsan_suppressions:print_suppressions=0"

# Get list of all test suites except the failing suite
TEST_SUITES=$(meson introspect --tests build | jq -r '.[] | select(.suite != "failing") | .name' | tr '\n' ' ')

# Run tests with verbose output
meson test -C build --print-errorlogs --verbose $TEST_SUITES

# Capture test exit status
TEST_STATUS=$?

# Print test logs if tests fail
if [ $TEST_STATUS -ne 0 ]; then
    echo "Tests failed with status $TEST_STATUS!"
    echo "Printing test logs..."
    cat ./build/meson-logs/testlog.txt
    exit $TEST_STATUS
fi

# Exit with test status
exit $TEST_STATUS