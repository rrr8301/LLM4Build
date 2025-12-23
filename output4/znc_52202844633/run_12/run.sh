#!/bin/bash

set -e

# Ensure git submodules are initialized
if [ -d .git ]; then
    git submodule update --init --recursive
else
    echo "No .git directory found. Ensure this is a git repository with submodules."
    exit 1
fi

# Install project dependencies
# Assuming .github/ubuntu_deps.sh installs necessary dependencies
if [ -f .github/ubuntu_deps.sh ]; then
    source .github/ubuntu_deps.sh
else
    echo "Dependency script not found. Exiting."
    exit 1
fi

# Build the project
if [ -f .github/build.sh ]; then
    source .github/build.sh
else
    echo "Build script not found. Exiting."
    exit 1
fi

# Run tests
set +e

# Check if a test target exists in the Makefile
if make -q test; then
    make test
else
    echo "No 'test' target found in Makefile. Skipping tests."
fi

# Check if znc is installed and run a version check
if command -v znc &> /dev/null; then
    znc --version
else
    echo "ZNC is not installed or not found in PATH."
fi

# Add coverage tool to PATH
export PATH="$PATH:/root/.local/bin"

# Additional checks for other commands
if command -v /root/perl5/bin/cover &> /dev/null; then
    /root/perl5/bin/cover --no-gcov --report=clover
else
    echo "Cover tool is not installed or not found in PATH."
fi

# Capture coverage data
lcov --directory . --capture --output-file lcov-coverage.txt --ignore-errors mismatch || echo "Failed to capture coverage data."

# List coverage data
lcov --list lcov-coverage.txt || echo "Failed to list coverage data."

set -e