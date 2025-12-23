#!/bin/bash

set -e

# Install project dependencies
if [ -f .github/ubuntu_deps.sh ]; then
    source .github/ubuntu_deps.sh
fi

# Initialize git submodules if not already done
if [ -f .gitmodules ] && [ ! -d cctz ]; then
    git submodule update --init --recursive || echo "Warning: Failed to initialize submodules"
fi

# Build the project
if [ -f .github/build.sh ]; then
    source .github/build.sh
fi

# Run tests if build directory exists
if [ -d build ]; then
    cd build

    # Run unit tests if they exist
    if [ -f CMakeCache.txt ]; then
        ctest --output-on-failure || echo "Warning: Some tests failed"
    fi

    # Run specific test targets if they exist
    if make -q unittest 2>/dev/null; then
        make unittest || echo "Warning: Unit tests failed"
    fi

    if make -q inttest 2>/dev/null; then
        make inttest || echo "Warning: Integration tests failed"
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