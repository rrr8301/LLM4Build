#!/bin/bash

# Activate Python environment
source /usr/bin/python3.11

# Install project dependencies
python3.11 -m pip install --only-binary ':all:' --no-binary curio --upgrade -e .[test]
python3.11 -m pip install --only-binary ':all:' --upgrade check-manifest pytest-cov pytest

# Build the project
python3.11 -m build
shasum -a 256 dist/*

# Check manifest
check-manifest

# Run tests
pytest --color=yes -raXxs --cov --cov-report=xml --maxfail=15 || true

# Note: Upload coverage to Codecov manually
echo "Please upload coverage.xml to Codecov manually."