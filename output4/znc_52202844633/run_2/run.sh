#!/bin/bash

# Activate any necessary environments (none specified)

# Install project dependencies
# Assuming .github/ubuntu_deps.sh installs necessary dependencies
source .github/ubuntu_deps.sh

# Build the project
source .github/build.sh

# Run tests
# Assuming tests are part of the build process or need to be run separately
# Ensure all tests are executed even if some fail
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