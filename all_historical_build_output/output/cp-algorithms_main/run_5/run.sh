#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests
# Adjust the path to the correct location of your test files
# Assuming tests are located in the current directory or a subdirectory
if [ -d "/app/tests" ]; then
    pytest /app/tests
else
    echo "Test directory /app/tests not found. Please ensure the tests are located in the correct directory."
    exit 1
fi