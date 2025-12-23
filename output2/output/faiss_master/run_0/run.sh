#!/bin/bash

# Activate Python environment (if any)
# Assuming no virtual environment is used, as it's not specified

# Install project dependencies
python3.12 -m pip install --upgrade pip
pip install -r requirements.txt

# Build the project
make

# Run tests and ensure all tests are executed
pytest --junitxml=test-results/results.xml || true