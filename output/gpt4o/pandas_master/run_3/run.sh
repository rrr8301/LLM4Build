#!/bin/bash

# Activate Python virtual environment
source /opt/venv/bin/activate

# Install project dependencies if not already installed
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
elif [ -f "requirements-dev.txt" ]; then
    pip install -r requirements-dev.txt
else
    pip install .
fi

# Build the project
python3.12 setup.py build

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
python3.12 -m pytest --junitxml=test-data.xml
set -e  # Re-enable exit on error