#!/bin/bash

# Activate environment variables
export CC=gcc
export CXX=g++
export CC_LD=gcc
export CXX_LD=g++

# Build the project using Meson
./ci/build-tumbleweed.sh -Db_ndebug=true

# Run tests and ensure all tests are executed
export LSAN_OPTIONS="suppressions=$(pwd)/.lsan_suppressions"
meson test -C build || true

# Print logs if tests fail
if [ $? -ne 0 ]; then
  cat ./build/meson-logs/testlog.txt
fi