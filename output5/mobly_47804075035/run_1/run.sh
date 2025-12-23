#!/bin/bash

# Create and activate a Python virtual environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -e .

# Run tests with tox
tox  # Run all tests

# Check formatting
pyink --check .  # Check formatting