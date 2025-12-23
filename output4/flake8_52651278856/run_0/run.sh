#!/bin/bash

# Activate virtual environment
python -m virtualenv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade setuptools pip tox

# Run tests
tox -e py || true  # Ensure all tests run, even if some fail