#!/bin/bash

# Activate Python environment (if any virtual environment is used, activate it here)

# Install project dependencies
python3.12 -m pip install --upgrade pip
pip install -r requirements.txt

# Build the project
python3.12 setup.py build

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
python3.12 -m pytest --junitxml=test-data.xml
set -e  # Re-enable exit on error