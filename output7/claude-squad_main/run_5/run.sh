#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if requirements.txt exists and install dependencies if it does
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
else
    echo "No requirements.txt found, skipping dependency installation."
fi

# Run tests
# Ensure all tests are executed, even if some fail
set +e

# Run pytest to execute tests
pytest

TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE