#!/bin/bash

# Create and activate virtual environment
python3 -m venv /venv
source /venv/bin/activate

# Upgrade pip
/venv/bin/python -m pip install --upgrade pip

# Install project dependencies
make dev-install pycoverage

# Run tests
set +e  # Continue on errors
make test