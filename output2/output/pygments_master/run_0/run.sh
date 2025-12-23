#!/bin/bash

# Activate Python environment (if any virtual environment is used)
# source /path/to/venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests with tox, ensuring all tests run even if some fail
set +e  # Do not exit immediately on error
tox -- -W error
set -e  # Re-enable exit on error