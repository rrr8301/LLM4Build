#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Activate environment (if needed, PyPy doesn't require activation like virtualenv)
# Install project dependencies
pip install -r requirements.txt || true

# Run tests with tox
tox -e pypy3.11 || true

# Ensure all tests are executed, even if some fail
set +e
tox -e pypy3.11