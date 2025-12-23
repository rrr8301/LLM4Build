#!/bin/bash

set -e

# Activate Python environment (if any)
# Assuming no virtual environment is specified, using system Python

# Install project dependencies
# Assuming no specific dependencies are mentioned, skipping pip install

# Run tests
set +e  # Ensure all tests run even if some fail
cd test
if [ -f ./test.sh ]; then
    ./test.sh
else
    echo "Error: test.sh not found in the test directory."
    exit 1
fi