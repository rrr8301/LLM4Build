#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Check if requirements.txt exists and install dependencies if it does
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
else
    echo "requirements.txt not found, skipping pip install"
fi

# Ensure tox and uv are installed in the virtual environment
pip install tox uv

# Run tests with tox using uv
uv run --locked tox run -e py3.11 || true  # Run tox and allow it to fail

# Ensure all tests are executed, even if some fail
set +e
uv run --locked tox run -e py3.11