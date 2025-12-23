#!/bin/bash

# Activate Python 3.12 environment
export PATH="/usr/bin/python3.12:$PATH"

# Install project dependencies
python3.12 -m pip install --upgrade pip
pip install -r requirements.txt || true

# Run tests
tox || true

# Generate coverage report
python3.12 -m coverage xml || true

# Placeholder for Codecov upload
echo "Upload coverage report to Codecov manually."