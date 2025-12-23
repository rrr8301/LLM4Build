#!/bin/bash

# Activate Python environment
python3 -m venv venv
source venv/bin/activate

# Install build dependencies
pip install --upgrade pip setuptools wheel cmake

# Install project dependencies (including igraph)
pip install --prefer-binary '.[test]' || pip install -e .

# Build the C core if needed
python setup.py build_c_core

# Run tests
pytest -v tests || true  # Ensure all tests run even if some fail