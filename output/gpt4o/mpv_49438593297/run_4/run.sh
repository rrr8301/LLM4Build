#!/bin/bash

# Activate environment variables
export CC=gcc
export CXX=g++
export CC_LD=lld
export CXX_LD=lld

# Configure installation prefix to avoid guessing issues
export DESTDIR=/usr/local

# Build the project using Meson with explicit prefix
./ci/build-tumbleweed.sh -Db_ndebug=true --prefix=/usr/local

# Check if build succeeded
if [ $? -ne 0 ]; then
    echo "Build failed!"
    cat ./build/meson-logs/meson-log.txt
    exit 1
fi

# Run tests and ensure all tests are executed
export LSAN_OPTIONS="suppressions=$(pwd)/.lsan_suppressions"
meson test -C build --print-errorlogs --no-suite=failing

# Print test logs if tests fail
if [ $? -ne 0 ]; then
    echo "Tests failed!"
    cat ./build/meson-logs/testlog.txt
    exit 1
fi