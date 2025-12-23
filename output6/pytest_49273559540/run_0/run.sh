#!/bin/bash

# Activate Python environment (if any virtual environment is used)
# For simplicity, we are using the system Python 3.9

# Install project dependencies
python3.9 -m pip install --upgrade pip
python3.9 -m pip install tox coverage

# Run tests
# Ensure all tests are executed, even if some fail
set +e
tox run -e py39-xdist --installpkg `find dist/*.tar.gz`
set -e

# Generate coverage report (if needed)
# python3.9 -m coverage xml

# Note: Codecov upload is ignored as it's an unsupported action