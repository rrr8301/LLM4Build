#!/bin/bash

# Activate Python environment (if any virtual environment is used)
# source /path/to/venv/bin/activate

# Install project dependencies
pip install -e .

# Run tests with tox
tox  # Ensure all tests run

# Check formatting
pyink --check .  # Ensure formatting check runs