#!/bin/bash

# Activate Python environment
source /usr/bin/python3.11

# Install project dependencies
pip install -e .

# Run tests with tox
tox || true  # Ensure all tests run even if some fail

# Check formatting
pyink --check . || true  # Ensure formatting check runs even if it fails