#!/bin/bash

# Activate Python environment (if any)
# Assuming no virtual environment is specified, using system Python

# Install project dependencies
pip install -r requirements.txt

# Build the project
python setup.py build

# Run tests and ensure all tests are executed
pytest --junitxml=reports/junit.xml --cov=. || true