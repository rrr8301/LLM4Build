#!/bin/bash

set -e

# Install project dependencies
if [ -f .github/ubuntu_deps.sh ]; then
    source .github/ubuntu_deps.sh
fi

# Initialize git submodules if not already done
if [ -f .gitmodules ] && [ -z "$(ls -A cctz)" ]; then
    git submodule update --init --recursive
fi

# Build the project
if [ -f .github/build.sh ]; then
    source .github/build.sh
fi

# Run tests
if [ -d build ]; then
    cd build

    # Run unit tests if they exist
    if [ -f CMakeCache.txt ]; then
        ctest --output-on-failure || true
    fi

    # Run specific test targets if they exist
    if make -q unittest 2>/dev/null; then
        make unittest || true
    fi

    if make -q inttest 2>/dev/null; then
        make inttest || true
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
    bash <(curl -s https://codecov.io/bash) || true
fi

exit 0