#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Ensure pip is up to date
pip install --upgrade pip

# Attempt to install project dependencies
# If editable mode fails, try a regular installation
pip install --upgrade -e .[test] || pip install --upgrade .[test] || { echo "Failed to install dependencies"; exit 1; }

# Install pytest explicitly if not part of the project dependencies
pip install pytest

# Run all tests, ensuring all are executed even if some fail
pytest --continue-on-collection-errors || true