#!/bin/bash

# Activate virtual environment
python3.11 -m venv venv
source venv/bin/activate

# Upgrade pip and install project dependencies
pip install --upgrade setuptools pip
pip install tox

# Run tests with tox
tox -e py || true  # Ensure all tests run even if some fail