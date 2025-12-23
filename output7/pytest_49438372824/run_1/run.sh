#!/bin/bash

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install tox coverage

# Build the package (assuming a setup.py or pyproject.toml is present)
python setup.py sdist

# Run tests with coverage
set +e  # Continue execution even if some tests fail
PACKAGE_FILE=$(find dist/*.tar.gz)
if [ -z "$PACKAGE_FILE" ]; then
    echo "No package file found in dist directory. Exiting."
    exit 1
fi
tox run -e py311-coverage --installpkg "$PACKAGE_FILE"
set -e

# Generate coverage report
python -m coverage xml

# Placeholder for uploading coverage to Codecov
echo "Upload coverage report to Codecov (not implemented in this script)"