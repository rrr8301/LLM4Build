#!/bin/bash

# Activate Python environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -e .

# Run tests with tox
tox  # Run all tests without skipping

# Check formatting
pyink --check .  # Run formatting check without skipping