#!/bin/bash

# Activate environment variables
export CC=gcc
export CXX=g++
export CC_LD=gcc
export CXX_LD=g++

# Build the project using Meson
./ci/build-tumbleweed.sh -Db_ndebug=true

# Check if build succeeded
if [ $? -ne 0 ]; then
    echo "Build failed!"
    cat ./build/meson-logs/meson-log.txt
    exit 1
fi

# Run tests and ensure all tests are executed
export LSAN_OPTIONS="suppressions=$(pwd)/.lsan_suppressions"
meson test -C build --print-errorlogs

# Print test logs if tests fail
if [ $? -ne 0 ]; then
    echo "Tests failed!"
    cat ./build/meson-logs/testlog.txt
    exit 1
fi