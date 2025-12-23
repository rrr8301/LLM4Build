#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"
export CGO_ENABLED=1

# Navigate to the directory containing the Go module
cd /app/_examples/rest || exit

# Install project dependencies
go mod download

# Check if Makefile exists and contains a test target
if [ -f Makefile ] && grep -q '^test:' Makefile; then
    # Check if middleware directory exists
    if [ ! -d "middleware" ]; then
        echo "Warning: 'middleware' directory not found. Creating directory."
        mkdir middleware
    fi

    # Check if there are Go files in the middleware directory
    if [ -z "$(ls -A middleware/*.go 2>/dev/null)" ]; then
        echo "Warning: No Go files found in 'middleware' directory. Skipping middleware tests."
    else
        # Run tests
        make test
    fi
else
    echo "Error: No 'test' target found in Makefile."
    exit 1
fi