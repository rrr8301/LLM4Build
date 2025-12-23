#!/bin/bash

# Activate Python environment
source /usr/bin/python3.11

# Install project dependencies
python3.11 -m pip install --upgrade pip
pip install tox coverage

# Run tests with coverage
tox run -e py311-coverage --installpkg `find dist/*.tar.gz` || true

# Generate coverage report
python3.11 -m coverage xml || true

# Placeholder for manual Codecov upload
echo "Upload coverage report manually or implement an alternative method."