#!/bin/bash

# Activate Python environment (if any virtual environment is used)
# source /path/to/venv/bin/activate

# Install project dependencies
python3 -m pip install --upgrade setuptools pip wheel
python3 -m pip install nox

# Run tests
# Ensure all tests are executed, even if some fail
set +e
nox -s unit
set -e