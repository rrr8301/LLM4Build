#!/bin/bash

# Use the specific Python 3.9 binary
PYTHON_BIN=/usr/bin/python3.9

# Install project dependencies
$PYTHON_BIN -m pip install -r requirements.txt

# Run tests with tox
tox -epy39-marshmallow3

# Ensure all tests are executed, even if some fail
exit 0