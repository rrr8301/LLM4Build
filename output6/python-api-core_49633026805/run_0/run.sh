#!/bin/bash

# Activate Python environment
python3.14 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade setuptools pip wheel
pip install nox

# Run tests
set +e  # Continue execution even if some tests fail
nox -s unit_grpc_gcp-3.14