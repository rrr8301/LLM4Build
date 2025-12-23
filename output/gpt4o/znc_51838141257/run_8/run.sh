#!/bin/bash

set -e

# Install project dependencies
if [ -f .github/ubuntu_deps.sh ]; then
    source .github/ubuntu_deps.sh
fi

# Ensure submodules are initialized (even if .git directory is missing)
if [ -f .gitmodules ]; then
    git submodule update --init --recursive || \
        { echo "Error: Failed to initialize submodules"; exit 1; }
fi

# Build the project
if [ -f .github/build.sh ]; then
    source .github/build.sh
elif [ -f configure ]; then
    mkdir -p build
    cd build
    ../configure --enable-debug --enable-perl --enable-python --enable-tcl --enable-cyrus --enable-charset --enable-argon || \
        { echo "Error: Configure failed"; exit 1; }
    make -j$(nproc) || { echo "Error: Build failed"; exit 1; }
    cd ..
fi

# Run tests if build directory exists
if [ -d build ]; then
    cd build

    # Run unit tests if they exist
    if [ -f CMakeCache.txt ]; then
        ctest --output-on-failure || { echo "Error: Tests failed"; exit 1; }
    fi

    # Run specific test targets if they exist
    if make -q unittest 2>/dev/null; then
        make unittest || { echo "Error: Unit tests failed"; exit 1; }
    fi

    if make -q inttest 2>/dev/null; then
        make inttest || { echo "Error: Integration tests failed"; exit 1; }
    fi

    # Generate coverage reports if possible
    if command -v lcov &> /dev/null; then
        lcov --directory . --capture --output-file lcov-coverage.txt --ignore-errors mismatch || true
        lcov --list lcov-coverage.txt || true
    fi

    if command -v cover &> /dev/null; then
        cover --no-gcov --report=clover || true
    fi

    # Upload to codecov
    bash <(curl -s https://codecov.io/bash) || echo "Warning: Codecov upload failed"
fi

exit 0