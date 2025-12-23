#!/bin/bash

# Activate the virtual environment
source /app/venv/bin/activate

# Install project dependencies if requirements.txt exists
if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi

# Run tests using pytest
# Exclude tests that are not suitable for a headless environment
set +e  # Do not exit immediately on error
pytest --maxfail=0 --ignore=Lib/idlelib  # Run all tests, do not stop on first failure, ignore idlelib tests