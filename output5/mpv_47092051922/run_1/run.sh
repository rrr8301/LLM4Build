#!/bin/bash

set -e

# Set environment variables
export CC=gcc
export CXX=g++
export CC_LD=gcc
export CXX_LD=g++

# Build with meson
./ci/build-tumbleweed.sh -Db_ndebug=true

# Run meson tests
export LSAN_OPTIONS="suppressions=$(pwd)/.lsan_suppressions"
meson test -C build

# Note: Skipping tests that require Docker environment