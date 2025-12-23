#!/bin/bash

# Activate the virtual environment
python3.12 -m venv .venv
source .venv/bin/activate

# Install project dependencies
python3.12 -m pip install --upgrade pip
python3.12 scripts/ci/install

# Run tests
set +e  # Continue executing even if some tests fail
python3.12 scripts/ci/run-tests --with-cov --with-xdist
set -e  # Stop execution on errors after tests

# Note: Code coverage upload is ignored due to unsupported action