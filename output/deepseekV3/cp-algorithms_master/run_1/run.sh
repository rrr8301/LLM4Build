#!/bin/bash

# Install any additional requirements if needed
if [ -f "preview/requirements.txt" ]; then
    pip install -r preview/requirements.txt
fi

# Run tests with error handling
set -e
echo "Running test suite..."

# Check if test script exists and run it
if [ -f "test/test.sh" ]; then
    ./test/test.sh
else
    echo "Error: test/test.sh not found"
    exit 1
fi

echo "Test execution completed"