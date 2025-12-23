#!/bin/bash

set -e

# Check if build.sh exists and is executable
if [ -x /app/build.sh ]; then
    # Build the project
    /app/build.sh
else
    echo "Error: /app/build.sh not found or not executable."
    exit 1
fi

# Ensure the _build directory exists
if [ ! -d "_build" ]; then
    echo "Error: _build directory not found."
    exit 1
fi

# Run tests
cd _build
make test  # Run all tests without skipping