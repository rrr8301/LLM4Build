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

# First try to run tests with tox
echo "Running tests with tox..."
tox -- -W error --rootdir=/app -v
EXIT_CODE=$?

# Exit with the test result code
exit $EXIT_CODE