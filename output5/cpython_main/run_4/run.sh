#!/bin/bash

# Activate the virtual environment
source /app/venv/bin/activate

# Install project dependencies if requirements.txt exists
if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi

# Run tests
# Ensure all tests are executed, even if some fail
set +e  # Do not exit immediately on error
make test