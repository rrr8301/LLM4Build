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
        echo "Error: 'middleware' directory not found."
        exit 1
    fi

    # Run tests
    make test
else
    echo "Error: No 'test' target found in Makefile."
    exit 1
fi