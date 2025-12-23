#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip setuptools wheel build
pip install --no-binary curio --no-binary psutil --no-binary tornado -e .[test_extra]
pip install --only-binary ':all:' check-manifest pytest-cov pytest

# Build the project
python -m build
shasum -a 256 dist/*

# Check manifest
check-manifest

# Run tests
pytest --color=yes -raXxs --cov --cov-report=xml --maxfail=15 || true

# Note: Uploading coverage to Codecov is not supported in this script.
# Please upload the coverage.xml manually if needed.