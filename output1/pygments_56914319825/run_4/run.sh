#!/bin/bash

# Install project in development mode
pip install -e .

# Set PYTHONPATH to include both app and tests
export PYTHONPATH=/app:/app/tests

# Check if tests exist and run them
set +e
if [ -d "/app/tests" ]; then
    echo "Running tests from /app/tests"
    # Run tox with pytest directly on the tests directory
    tox -- -W error --rootdir=/app /app/tests
else
    echo "Warning: Tests directory not found at /app/tests, checking alternative locations..."
    # Try to find tests in other common locations
    TEST_DIR=$(find /app -type d -name tests -print -quit)
    if [ -n "$TEST_DIR" ]; then
        echo "Found tests at $TEST_DIR"
        tox -- -W error --rootdir=/app "$TEST_DIR"
    else
        echo "Error: No tests directory found"
        exit 1
    fi
fi
EXIT_CODE=$?
set -e

# Exit with the test result code
exit $EXIT_CODE