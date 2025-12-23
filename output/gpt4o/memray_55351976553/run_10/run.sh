#!/bin/bash

# Activate virtual environment
source /venv/bin/activate

# Install test dependencies if requirements-test.txt exists
if [ -f "requirements-test.txt" ]; then
    pip install -r requirements-test.txt
fi

# Run tests with coverage
set +e  # Continue on errors
make pycoverage