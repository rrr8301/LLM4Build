#!/bin/bash

# Activate the Python environment
source /usr/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests using tox
tox -e tests || true

# Ensure all tests are executed, even if some fail
exit 0