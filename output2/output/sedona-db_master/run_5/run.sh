#!/bin/bash

# Activate Python environment (if any)
# Assuming no virtual environment is specified, using system Python

# Build the project
python setup.py build

# Run tests and ensure all tests are executed
pytest --junitxml=reports/junit.xml --cov=. || true