#!/bin/bash

# Activate the virtual environment
source /app/.venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install -e .[test]

# Run tests
set +e  # Continue execution even if some tests fail
make test