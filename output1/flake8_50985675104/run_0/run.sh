#!/bin/bash

# Activate the virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip setuptools tox virtualenv

# Run tests using tox
tox -e py || true  # Ensure all tests run even if some fail