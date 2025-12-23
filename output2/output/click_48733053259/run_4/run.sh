#!/bin/bash

# Activate Python environment
python3.10 -m venv venv
source venv/bin/activate

# Install project dependencies
if [ -f requirements.txt ]; then
    pip install -r requirements.txt
else
    echo "requirements.txt not found, please ensure it is present in the project directory."
    exit 1
fi

# Run tests with tox
set +e  # Continue execution even if some tests fail
uv run --locked tox run -e py3.10