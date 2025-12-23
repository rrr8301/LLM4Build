#!/bin/bash

set -e

# Activate Python environment
python3 -m venv venv
source venv/bin/activate

# Check if requirements.txt exists
if [ ! -f /app/requirements.txt ]; then
    echo "Error: requirements.txt not found!"
    exit 1
fi

# Install project dependencies
pip install --no-cache-dir -r /app/requirements.txt

# Build source distribution
python3 -m build --sdist

# Run tests
make test

# Deactivate the environment
deactivate