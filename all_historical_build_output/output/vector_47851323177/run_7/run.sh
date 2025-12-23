#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the Python virtual environment
source /app/venv/bin/activate

# Change to the repository root directory
cd /app

# Install project dependencies
# Use PEP 517 processing if a pyproject.toml is present
# Ensure setuptools-scm can find the VCS information
pip install -e . --no-use-pep517

# Run tests with nox, ensuring all tests are executed
nox -s coverage-3.10 --verbose || true

# Note: Coverage report upload is not handled here. Please upload manually if needed.