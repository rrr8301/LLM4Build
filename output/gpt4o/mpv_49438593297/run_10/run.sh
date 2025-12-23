#!/bin/bash

# Set compiler and linker
export CC=gcc
export CXX=g++
export CC_LD=lld
export CXX_LD=lld

# Run tests with LSAN options and verbose output
export LSAN_OPTIONS="suppressions=$(pwd)/.lsan_suppressions:print_suppressions=0"

# Run all tests with verbose output (don't exclude any suites)
meson test -C build --print-errorlogs --verbose

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