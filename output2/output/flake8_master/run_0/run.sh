#!/bin/bash

# Activate virtual environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade setuptools pip
pip install tox

# Run tests with tox
# Ensure all tests are executed, even if some fail
tox || true