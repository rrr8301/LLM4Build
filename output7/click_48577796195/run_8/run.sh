#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# For PyPy, no specific activation is needed beyond ensuring the correct interpreter is used

# Install project dependencies
pip install -r requirements.txt

# Run tests with tox
# Ensure all tests are executed, even if some fail
set +e
tox -e pypy3
set -e