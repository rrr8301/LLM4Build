#!/bin/bash

# Activate the Python environment
source /usr/bin/activate

# Install project dependencies
python3.10 -m pip install --upgrade setuptools pip wheel nox

# Run unit tests with nox
# Ensure all tests are executed, even if some fail
nox -s unit-3.10 || true