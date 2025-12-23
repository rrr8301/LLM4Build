#!/bin/bash

# Activate the environment (if any)
# No specific virtual environment setup is mentioned, so we skip this step

# Install project dependencies
if [ -f requirements.txt ]; then
    pip3 install -r requirements.txt
else
    echo "requirements.txt not found, skipping dependency installation."
fi

# Check if the tests directory exists
if [ -d tests ]; then
    # Run tests
    pytest tests/
else
    echo "tests/ directory not found, skipping tests."
fi

# Ensure all tests are executed, even if some fail
set +e
if [ -d tests ]; then
    pytest tests/
fi