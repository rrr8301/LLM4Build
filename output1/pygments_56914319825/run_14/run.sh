#!/bin/bash

# Install project in development mode
pip install -e .

# Set PYTHONPATH to include the app
export PYTHONPATH=/app

# Check if tox.ini exists
if [ ! -f "/app/tox.ini" ]; then
    echo "Error: tox.ini not found at /app/tox.ini"
    exit 1
fi

# First try to run tests with tox with explicit test paths
echo "Running tests with tox..."
tox -- -W error --rootdir=/app -v tests/
EXIT_CODE=$?

# If tox fails with no tests found, try direct pytest
if [ $EXIT_CODE -eq 5 ]; then
    echo "No tests found via tox, trying direct pytest..."
    pytest -W error --rootdir=/app -v tests/
    EXIT_CODE=$?
fi

# Exit with the test result code
exit $EXIT_CODE