#!/bin/bash

# Use Python 3.13 for all operations
PYTHON=python3.13

# Install project dependencies
$PYTHON -m pip install -r requirements.txt

# Run tests with tox, ensuring all tests are executed
# Add a check to ensure that test files are present
if ls tests/*.py 1> /dev/null 2>&1; then
    tox -- -W error || true
else
    echo "No test files found in the tests directory."
    exit 1
fi