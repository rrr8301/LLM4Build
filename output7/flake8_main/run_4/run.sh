#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the virtual environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --no-cache-dir -r requirements.txt

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on test failure
pytest --maxfail=0  # Replace with the actual test command if different

# Deactivate the virtual environment
deactivate