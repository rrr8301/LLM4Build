#!/bin/bash

# Create and activate virtual environment
python3.12 -m venv /app/venv
source /app/venv/bin/activate

# Upgrade pip and install dependencies
/app/venv/bin/python -m pip install --upgrade pip
/app/venv/bin/python -m pip install -r test-requirements.txt
/app/venv/bin/python -m pip install tox

# Run tests
set +e  # Continue on error
./ci.sh
set -e  # Stop on error