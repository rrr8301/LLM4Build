#!/bin/bash

# Activate the virtual environment
source /opt/venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests using tox
set +e

# Check if tox.ini exists and contains the correct environment
if [ -f tox.ini ]; then
    # List available environments to ensure the correct one is used
    tox -l
    # Run tests using the correct environment
    tox -e py311 || tox -e py3.11
else
    echo "tox.ini not found or incorrect environment specified."
    exit 1
fi