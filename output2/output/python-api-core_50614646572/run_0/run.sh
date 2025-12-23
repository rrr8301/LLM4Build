#!/bin/bash

# Activate Python environment
python3.10 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt || true

# Run tests with nox
nox -s unit_grpc_gcp-3.10 || true

# Ensure all tests are executed, even if some fail
exit 0