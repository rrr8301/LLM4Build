#!/bin/bash

# Set compiler and linker
export CC=gcc
export CXX=g++
export CC_LD=lld
export CXX_LD=lld

# Run tests with LSAN options
export LSAN_OPTIONS="suppressions=$(pwd)/.lsan_suppressions"
meson test -C build --print-errorlogs --no-suite=failing

# Print test logs if tests fail
if [ $? -ne 0 ]; then
    echo "Tests failed!"
    cat ./build/meson-logs/testlog.txt
    exit 1
fi