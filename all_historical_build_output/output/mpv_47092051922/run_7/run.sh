#!/bin/bash

set -e

# Set environment variables
export CC=gcc
export CXX=g++
export CC_LD=gcc
export CXX_LD=g++

# Ensure the build directory exists
mkdir -p build

# Build with meson
meson setup build -Db_ndebug=true || { echo "Meson setup failed"; exit 1; }

# Compile the project
ninja -C build || { echo "Ninja build failed"; exit 1; }

# Run meson tests
export LSAN_OPTIONS="suppressions=$(pwd)/.lsan_suppressions"
meson test -C build || { echo "Meson tests failed"; exit 1; }

# Note: Skipping tests that require Docker environment