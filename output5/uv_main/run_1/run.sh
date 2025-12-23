#!/bin/bash

# Activate the environment (if any)
# No specific virtual environment setup is mentioned, so we skip this step

# Install project dependencies
if [ -f requirements.txt ]; then
    pip3 install -r requirements.txt
else
    echo "requirements.txt not found, skipping dependency installation."
fi

# Run tests
# Assuming a test command, replace with actual test command if known
pytest tests/

# Ensure all tests are executed, even if some fail
set +e
pytest tests/