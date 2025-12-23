#!/bin/bash

# Activate Python environment (if any)
# Assuming no virtual environment is used, as it's not specified

# Install project dependencies if requirements.txt is present
if [ -f /app/requirements.txt ]; then
    python3 -m pip install --upgrade pip
    pip install -r /app/requirements.txt
fi

# Build the project
make

# Run tests and ensure all tests are executed
pytest --junitxml=test-results/results.xml