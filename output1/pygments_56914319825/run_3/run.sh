#!/bin/bash

# Install project in development mode
pip install -e .

# Ensure test files are discoverable by adding tests directory to PYTHONPATH
export PYTHONPATH=/app:/app/tests

# Run tests with tox, ensuring all tests run even if some fail
# The -W error flag makes warnings into errors as per the original workflow
# Explicitly specify test directory for pytest and ensure it exists
set +e
if [ -d "/app/tests" ]; then
    tox -- -W error --rootdir=/app /app/tests
else
    echo "Error: Tests directory not found at /app/tests"
    exit 1
fi
EXIT_CODE=$?
set -e

# Exit with the test result code
exit $EXIT_CODE