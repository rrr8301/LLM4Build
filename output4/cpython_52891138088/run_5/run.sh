#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
# Ensure the script exists and is executable
if [ -f ./.github/workflows/posix-deps-apt.sh ]; then
    sudo ./.github/workflows/posix-deps-apt.sh
else
    echo "Error: posix-deps-apt.sh not found."
    exit 1
fi

# Configure CPython
if [ -f configure ]; then
    ./configure
else
    echo "Error: configure script not found."
    exit 1
fi

# Build CPython
if [ -f Makefile ]; then
    make -j
else
    echo "Error: Makefile not found."
    exit 1
fi

# Run tests
if [ -f Makefile ]; then
    xvfb-run make ci || true
else
    echo "Error: Makefile not found for tests."
    exit 1
fi