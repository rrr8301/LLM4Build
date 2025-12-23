#!/bin/bash

# Activate the Python environment
source /usr/bin/python3.9

# Install project dependencies
pip install -r requirements.txt || true

# Run tests with tox
tox -epy39-marshmallow3 || true

# Ensure all tests are executed, even if some fail
exit 0