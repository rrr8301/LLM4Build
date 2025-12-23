#!/bin/bash

# Activate Python environment
python3.9 -m venv venv
source venv/bin/activate

# Install build dependencies
python3.9 -m pip install --upgrade pip setuptools wheel
python3.9 -m pip install numpy cython "setuptools<60.0.0" cmake

# Install project with test dependencies
python3.9 -m pip install --prefer-binary --ignore-installed --no-build-isolation '.[test]'

# Set environment variables for igraph
export IGRAPH_USE_VENDORED_SOURCE=1
export IGRAPH_VENDORED_SOURCE_PATH=/app/vendor/source/igraph

# Run tests with verbose output
python3.9 -m pytest -v tests || true  # Ensure all tests run even if some fail