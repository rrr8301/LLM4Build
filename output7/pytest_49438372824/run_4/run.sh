#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install tox coverage build pytest

# Check if setup.py or pyproject.toml exists and build the package accordingly
if [ -f "setup.py" ]; then
    python setup.py sdist
elif [ -f "pyproject.toml" ]; then
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

# Ensure tox is configured correctly
if [ ! -f "tox.ini" ]; then
    echo "[tox]" > tox.ini
    echo "envlist = py311-coverage" >> tox.ini
    echo "[testenv]" >> tox.ini
    echo "deps = coverage pytest" >> tox.ini
    echo "commands = coverage run -m pytest" >> tox.ini
fi

tox -e py311-coverage --installpkg "$PACKAGE_FILE"
set -e

# Generate coverage report
python -m coverage xml

# Placeholder for uploading coverage to Codecov
echo "Upload coverage report to Codecov (not implemented in this script)"