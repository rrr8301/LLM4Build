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

set -e