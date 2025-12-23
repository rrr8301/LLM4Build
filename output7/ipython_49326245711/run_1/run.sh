#!/bin/bash

# Activate Python environment (if any)
# Assuming no virtual environment is explicitly created

# Install project dependencies
python3.11 -m pip install --only-binary ':all:' --no-binary curio --upgrade -e .[test_extra]

# Run build and check manifest
python3.11 -m build
shasum -a 256 dist/*
check-manifest

# Run tests
pytest --color=yes -raXxs --cov --cov-report=xml --maxfail=15 || true

# Placeholder for Codecov upload
echo "Upload coverage to Codecov manually if needed."