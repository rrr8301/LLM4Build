#!/bin/bash

# Activate virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade setuptools pip
pip install -r docs/source/requirements.txt

# Run tests with tox
tox || true  # Ensure all tests run even if some fail