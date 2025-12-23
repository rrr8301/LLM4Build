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

# First run pytest directly to verify test discovery
echo "Running pytest directly to verify test discovery..."
set +e
pytest --rootdir=/app --collect-only tests/
if [ $? -ne 0 ]; then
    echo "Error: No tests discovered with pytest directly"
    exit 1
fi
set -e

# Run tox with pytest
echo "Running tests using tox..."
set +e
tox -- -W error --rootdir=/app -v tests/
EXIT_CODE=$?
set -e

# Exit with the test result code
exit $EXIT_CODE