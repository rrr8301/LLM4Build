#!/bin/bash

# Activate Python environment (if any)
# Assuming no virtual environment is specified, using system Python

# Build the project
if [ -f setup.py ]; then
    python setup.py build
else
    echo "setup.py not found, skipping build step."
fi

# Run tests and ensure all tests are executed
if command -v pytest &> /dev/null; then
    pytest --junitxml=reports/junit.xml --cov=. || true
else
    echo "pytest not installed, skipping tests."
fi