#!/bin/bash

# Activate virtual environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip setuptools wheel
pip install --no-binary curio --upgrade -e .[test]
pip install --upgrade check-manifest pytest-cov pytest

# Build the project
python -m build
shasum -a 256 dist/*

# Check manifest
check-manifest

# Run tests
pytest --color=yes -raXxs --cov --cov-report=xml --maxfail=15 || true

# Note: Coverage upload to Codecov is not handled in this script.