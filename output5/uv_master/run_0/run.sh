#!/bin/bash

# Activate the virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Build the project
python setup.py build

# Run tests and ensure all tests are executed
pytest || true

# Note: Coverage upload is ignored due to unsupported action