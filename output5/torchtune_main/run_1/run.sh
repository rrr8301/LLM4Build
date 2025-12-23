#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the virtual environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests
# Assuming tests are run using pytest
pytest --maxfail=0 --continue-on-collection-errors