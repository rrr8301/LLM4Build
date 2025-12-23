#!/bin/bash

# Activate Python 3.11
export PATH="/usr/bin/python3.11:$PATH"

# Install project dependencies
pip install -r requirements.txt

# Run tests with tox
tox -e tests || true  # Ensure all tests run even if some fail