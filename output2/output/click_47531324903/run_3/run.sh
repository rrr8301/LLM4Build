#!/bin/bash

# Activate Python environment
python3.13 -m venv venv
source venv/bin/activate

# Upgrade pip and setuptools
pip install --upgrade pip setuptools

# Install project dependencies
pip install -r requirements.txt || true

# Run tests with tox
set +e  # Ensure all tests run even if some fail
tox -e py3.13