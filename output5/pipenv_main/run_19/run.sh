#!/bin/bash

# Ensure the script exits on any error
set -e

# Install project dependencies and lock them
pipenv lock --pre --clear
pipenv install --dev

# Run tests using pipenv run to ensure the virtual environment is used
# Ensure all tests run even if some fail
set +e
pipenv run pytest --maxfail=0