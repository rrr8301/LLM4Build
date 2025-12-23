#!/bin/bash

# Activate the virtual environment
source /app/.venv/bin/activate

# Install project dependencies
pip install --upgrade pip setuptools
pip install -e .[test]

# Run tests
set +e  # Continue execution even if some tests fail
make test
status=$?

# Exit with the status of the test command
exit $status