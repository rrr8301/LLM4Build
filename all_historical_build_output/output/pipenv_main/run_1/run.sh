#!/bin/bash

# Install project dependencies
pipenv install --dev

# Run tests using pipenv run to ensure the virtual environment is used
# Ensure all tests run even if some fail
set +e
pipenv run pytest --maxfail=0