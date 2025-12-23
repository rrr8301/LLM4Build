#!/bin/bash

set -e

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install tox

# Build the project to create distribution files
python setup.py sdist bdist_wheel

# Ensure the dist directory exists and contains the necessary files
if [ ! -d "dist" ] || [ -z "$(ls -A dist/*.tar.gz 2>/dev/null)" ]; then
    echo "Error: No distribution files found in the dist directory."
    exit 1
fi

# Extract pre-built packages
tar xf dist/*.tar.gz --strip-components=1

# Prepare tox environment
DO_MYPY=1
TOX_PYTHON=py311

# Run mypy if applicable
if [ "$DO_MYPY" -eq 1 ]; then
    tox -e $TOX_PYTHON-mypy || true
fi

# Remove src to ensure tests run against wheel
rm -rf src

# Run tests
tox --installpkg dist/*.whl -e $TOX_PYTHON-tests || true