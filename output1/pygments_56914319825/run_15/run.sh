#!/bin/bash

# Install project in development mode
pip install -e .

# Set PYTHONPATH to include the app
export PYTHONPATH=/app

# Check if tests directory exists
if [ ! -d "/app/tests" ]; then
    echo "Warning: tests directory not found at /app/tests"
    echo "Looking for tests in alternative locations..."
    
    # Try to find tests in the package directory
    if [ -d "/app/pygments/tests" ]; then
        TEST_PATH="/app/pygments/tests"
    else
        echo "Error: No tests directory found"
        exit 1
    fi
else
    TEST_PATH="/app/tests"
fi

# First try to run tests with tox
echo "Running tests with tox..."
tox -- -W error --rootdir=/app -v $TEST_PATH
EXIT_CODE=$?

# If tox fails with no tests found, try direct pytest
if [ $EXIT_CODE -eq 5 ]; then
    echo "No tests found via tox, trying direct pytest..."
    pytest -W error --rootdir=/app -v $TEST_PATH
    EXIT_CODE=$?
fi

# Exit with the test result code
exit $EXIT_CODE