#!/bin/bash

set -e

# Install project dependencies
if [ -f "./ci/set_gcc_10.sh" ]; then
    ./ci/set_gcc_10.sh
else
    echo "Warning: ./ci/set_gcc_10.sh not found, skipping."
fi

# Build Boost if not cached
if [ ! -d "$HOME/boost-prefix" ]; then
    if [ -f "./.github/depends/boost.sh" ]; then
        ./.github/depends/boost.sh -b 64 -t gcc -p $HOME/boost-prefix
    else
        echo "Error: ./.github/depends/boost.sh not found."
        exit 1
    fi
fi

# Build Zlib if not cached
if [ ! -d "$HOME/zlib-prefix" ]; then
    if [ -f "./.github/depends/zlib.sh" ]; then
        ./.github/depends/zlib.sh -b 64 -p $HOME/zlib-prefix
    else
        echo "Error: ./.github/depends/zlib.sh not found."
        exit 1
    fi
fi

# Compile tests
mkdir -p build
cmake \
    -D MSGPACK_CXX20=ON \
    -D MSGPACK_32BIT=OFF \
    -D MSGPACK_CHAR_SIGN=signed \
    -D MSGPACK_USE_X3_PARSE=ON \
    -D MSGPACK_BUILD_EXAMPLES=ON \
    -D MSGPACK_BUILD_TESTS=ON \
    -D CMAKE_BUILD_TYPE=Debug \
    -D MSGPACK_GEN_COVERAGE=ON \
    -D MSGPACK_USE_STD_VARIANT_ADAPTOR=ON \
    -D CMAKE_PREFIX_PATH="$HOME/zlib-prefix/64;$HOME/boost-prefix/64" \
    -B build \
    -S . || exit 1

cmake --build build --target all || exit 1

# Run tests and ensure all tests are executed
ctest --test-dir build || true

# Generate coverage report
cd build
lcov --capture --directory . --output-file coverage.info --ignore-errors mismatch
lcov --remove coverage.info '/usr/*' --output-file coverage.info
lcov --list coverage.info