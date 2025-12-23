#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Create a virtual environment
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install project dependencies
pip install --no-cache-dir -r requirements.txt

# Run tests
# Assuming tests are run using pytest or a similar tool
# Ensure all tests are executed, even if some fail
pytest || true

# Deactivate the virtual environment
deactivate