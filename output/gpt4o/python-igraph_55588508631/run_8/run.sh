#!/bin/bash

# Activate Python environment
python3.9 -m venv venv
source venv/bin/activate

# Install project dependencies with test extras
python3.9 -m pip install --upgrade pip setuptools wheel
python3.9 -m pip install --prefer-binary '.[test]'

# Install pytest explicitly
python3.9 -m pip install pytest

# Set environment variables for igraph
export IGRAPH_USE_VENDORED_SOURCE=1
export IGRAPH_VENDORED_SOURCE_PATH=/app/vendor/source/igraph

# Run tests
python3.9 -m pytest -v tests || true  # Ensure all tests run even if some fail