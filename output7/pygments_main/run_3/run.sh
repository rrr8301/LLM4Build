#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Create a virtual environment and activate it
python3 -m venv venv
source venv/bin/activate

# Upgrade pip to the latest version
pip install --upgrade pip

# Install project dependencies
pip install -e .
pip install -r requirements.txt

# Install tox if it's not already installed
pip install tox

# Check if there are any test files
if ! ls tests/test_*.py 1> /dev/null 2>&1; then
    echo "No test files found. Ensure your test files are named correctly (e.g., test_*.py) and located in the 'tests' directory."
    echo "Please add test files to the 'tests' directory and try again."
    exit 1
fi

# Run tests using tox
# Ensure all tests are executed, even if some fail
set +e
tox -- -W error