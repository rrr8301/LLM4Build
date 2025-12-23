#!/bin/bash

# Use Python 3.13 for all operations
PYTHON=python3.13

# Install project dependencies
$PYTHON -m pip install -r requirements.txt

# Run tests with tox, ensuring all tests are executed
tox -- -W error || true