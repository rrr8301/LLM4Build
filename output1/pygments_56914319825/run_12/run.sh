#!/bin/bash

# Install project in development mode
pip install -e .

# Set PYTHONPATH to include both app and tests
export PYTHONPATH=/app:/app/tests

# Check if tox.ini exists
if [ ! -f "/app/tox.ini" ]; then
    echo "Error: tox.ini not found at /app/tox.ini"
    exit 1
fi

# First try to run tests directly with pytest
echo "Attempting to run tests directly..."
if [ -d "/app/tests" ]; then
    cd /app
    pytest --rootdir=/app -v tests/
    EXIT_CODE=$?
else
    echo "Error: tests directory not found at /app/tests"
    exit 1
fi

# If direct pytest fails, try with tox
if [ $EXIT_CODE -ne 0 ]; then
    echo "Direct test run failed, trying with tox..."
    tox -- -W error --rootdir=/app -v
    EXIT_CODE=$?
fi

# Exit with the test result code
exit $EXIT_CODE