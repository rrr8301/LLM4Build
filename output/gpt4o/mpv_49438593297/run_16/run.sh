#!/bin/bash

# Set compiler and linker
export CC=gcc
export CXX=g++
export CC_LD=lld
export CXX_LD=lld

# Configure LSAN options
export LSAN_OPTIONS="suppressions=$(pwd)/.lsan_suppressions:print_suppressions=0:verbosity=1:log_threads=1"

# Ensure build directory exists and tests are enabled
if [ ! -d "./build" ]; then
    meson setup build -Dtests=enabled
fi

# Rebuild if needed
meson compile -C build

# Run all tests except explicitly skipped ones
meson test -C build \
    --print-errorlogs \
    --verbose \
    --no-rebuild \
    --num-processes=1 \
    --no-suite flaky \
    --no-suite benchmark

# Capture test exit status
TEST_STATUS=$?

# Print test logs if tests fail
if [ $TEST_STATUS -ne 0 ]; then
    echo "Tests failed with status $TEST_STATUS!"
    echo "Printing test logs..."
    cat ./build/meson-logs/testlog.txt
    exit $TEST_STATUS
fi

exit 0