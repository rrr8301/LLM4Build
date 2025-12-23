#!/bin/bash

# Activate virtual environment if needed
# source /path/to/venv/bin/activate

# Install project dependencies
pip install -e .

# Run tests with tox
tox  # Ensure all tests run

# Check formatting
pyink --check .  # Ensure formatting check runs