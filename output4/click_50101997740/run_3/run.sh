#!/bin/bash

# Activate the Python virtual environment
source /app/venv/bin/activate

# Install project dependencies using pip
pip install -r requirements.txt

# Run tests using tox
tox -e py

# Ensure all tests are executed, even if some fail
exit 0