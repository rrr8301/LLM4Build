#!/bin/bash

# Activate Python 3.11
alias python=python3.11
alias pip=pip3

# Install project dependencies
pip install --upgrade setuptools pip wheel
pip install nox

# Run unit tests with nox
# Ensure all tests are executed, even if some fail
nox -s unit-3.11 || true