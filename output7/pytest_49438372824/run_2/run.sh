#!/bin/bash

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install tox coverage

# Check if setup.py or pyproject.toml exists and build the package accordingly
if [ -f "setup.py" ]; then
    python setup.py sdist
elif [ -f "pyproject.toml" ]; then
    pip install build
    python -m build
else
    echo "No setup.py or pyproject.toml found. Exiting."
    exit 1
fi

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