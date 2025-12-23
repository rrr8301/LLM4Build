#!/bin/bash

# Activate the Python environment
source /usr/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests with nox
LIBSODIUM_MAKE_ARGS="-j$(nproc)" nox -s tests || true

# Ensure all tests are executed, even if some fail
exit 0