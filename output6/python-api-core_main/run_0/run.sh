#!/bin/bash

# Activate Python environment (if any virtual environment is used, activate it here)

# Install project dependencies (if any specific dependencies are listed in requirements files)
# For example, if there's a requirements.txt, uncomment the following line:
# python3.12 -m pip install -r requirements.txt

# Run tests using nox
set +e  # Continue execution even if some tests fail
nox -s unit
set -e