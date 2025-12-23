#!/bin/bash

# Source environment setup scripts
if [ -f .github/ubuntu_deps.sh ]; then
    source .github/ubuntu_deps.sh
else
    echo "Missing .github/ubuntu_deps.sh"
    exit 1
fi

if [ -f .github/build.sh ]; then
    source .github/build.sh
else
    echo "Missing .github/build.sh"
    exit 1
fi

# Run tests
# Ensure all tests run even if some fail
set +e

# Check if the 'test' target exists in the Makefile
if make -q test; then
    make test
else
    echo "No 'test' target found in Makefile"
fi

# Check if the 'unittest' target exists in the Makefile
if make -q unittest; then
    make unittest
else
    echo "No 'unittest' target found in Makefile"
fi

# Check if the 'inttest' target exists in the Makefile
if make -q inttest; then
    make inttest
else
    echo "No 'inttest' target found in Makefile"
fi

# Check if znc is installed
if ! command -v znc &> /dev/null; then
    echo "znc could not be found"
    exit 1
fi

# Run lcov and handle missing .gcda files
lcov --directory . --capture --output-file lcov-coverage.txt --ignore-errors mismatch,empty
lcov --list lcov-coverage.txt || echo "No valid records found in tracefile"

set -e