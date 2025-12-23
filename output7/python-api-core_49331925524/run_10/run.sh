#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt  # Do not skip any package installations

# Run tests using nox
nox -s unit-3.11  # Do not skip any tests

# Deactivate the virtual environment
deactivate