#!/bin/bash

# run.sh

# Activate virtual environment if needed (not using venv here for simplicity)
# Install project dependencies
python3.11 -m pip install --upgrade pip
python3.11 -m pip install tox

# Run tests with tox
# Ensure all tests are executed, even if some fail
tox -e tests || true