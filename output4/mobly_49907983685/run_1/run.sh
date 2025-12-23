#!/bin/bash

# Activate Python environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install -e .

# Run tests with tox
tox  # Ensure all tests run

# Check formatting
pyink --check .  # Ensure formatting check runs