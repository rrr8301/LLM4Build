#!/bin/bash

# Activate the virtual environment
source /app/venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests
# Ensure all tests are executed, even if some fail
set +e  # Do not exit immediately on error
make test