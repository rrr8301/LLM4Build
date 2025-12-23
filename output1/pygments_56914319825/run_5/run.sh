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

# Run tox with pytest directly
echo "Running tests using tox..."
set +e
tox -- -W error --rootdir=/app
EXIT_CODE=$?
set -e

# Exit with the test result code
exit $EXIT_CODE