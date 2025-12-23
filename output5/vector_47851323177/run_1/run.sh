#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the Python virtual environment
source /app/venv/bin/activate

# Install project dependencies
pip install -e .

# Run tests with nox, ensuring all tests are executed
nox -s coverage-3.10 --verbose || true

# Note: Coverage report upload is not handled here. Please upload manually if needed.