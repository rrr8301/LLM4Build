#!/bin/bash

# Activate the virtual environment
pipenv shell

# Install project dependencies
pipenv install --dev

# Run tests
# Assuming tests are run using a command like `pytest`
# Ensure all tests run even if some fail
set +e
pytest --maxfail=0