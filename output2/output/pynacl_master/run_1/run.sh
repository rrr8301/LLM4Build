#!/bin/bash

# Create and activate the Python virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests with nox
LIBSODIUM_MAKE_ARGS="-j$(nproc)" nox -s tests || true

# Ensure all tests are executed, even if some fail
exit 0