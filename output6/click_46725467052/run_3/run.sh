#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Check if requirements.txt exists and install dependencies if it does
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
else
    echo "requirements.txt not found, skipping pip install"
fi

# Run tests with tox
tox

# Ensure all tests are executed, even if some fail
set +e
tox