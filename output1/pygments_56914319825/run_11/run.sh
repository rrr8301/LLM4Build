#!/bin/bash

# Install project in development mode
pip install -e .

# Set PYTHONPATH to include both app and tests if tests directory exists
export PYTHONPATH=/app
if [ -d "/app/tests" ]; then
    export PYTHONPATH=$PYTHONPATH:/app/tests
fi

# Check if tox.ini exists
if [ ! -f "/app/tox.ini" ]; then
    echo "Error: tox.ini not found at /app/tox.ini"
    exit 1
fi

# First try to discover tests with pytest
echo "Attempting to discover tests..."
TEST_DISCOVERY_OUTPUT=$(pytest --rootdir=/app --collect-only 2>&1)

if [[ $TEST_DISCOVERY_OUTPUT == *"collected 0 items"* ]]; then
    echo "Warning: No tests discovered with pytest directly, trying alternative approach..."
    
    # Try running tests directly if tests directory exists
    if [ -d "/app/tests" ]; then
        cd /app/tests
        pytest --rootdir=/app -v
        EXIT_CODE=$?
    else
        echo "Warning: tests directory not found, running tox directly"
        tox -- -W error --rootdir=/app -v
        EXIT_CODE=$?
    fi
else
    # Run tox with pytest
    echo "Running tests using tox..."
    tox -- -W error --rootdir=/app -v
    EXIT_CODE=$?
fi

# Exit with the test result code
exit $EXIT_CODE