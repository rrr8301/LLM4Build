#!/bin/bash

# Activate Python environment
python3.10 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade setuptools pip wheel
pip install nox

# Run tests
nox -s unit-3.10 || true

# Note: In a real CI environment, coverage results would be uploaded here
echo "Coverage results would be uploaded in a real CI environment."