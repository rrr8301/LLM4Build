#!/bin/bash

# Install project in development mode
pip install -e .

# Set PYTHONPATH to include the app
export PYTHONPATH=/app

# Default test path (changed to match Pygments test directory structure)
TEST_PATH="/app/pygments/tests"

# Check if tests directory exists
if [ ! -d "$TEST_PATH" ]; then
    echo "Error: Tests directory not found at $TEST_PATH"
    exit 1
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