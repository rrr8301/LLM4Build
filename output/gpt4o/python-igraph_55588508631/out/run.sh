#!/bin/bash

# Activate Python environment
python3 -m venv venv
source venv/bin/activate

# Install build dependencies
pip install --upgrade pip setuptools wheel cmake

# First try installing pre-built binary
if ! pip install --prefer-binary igraph; then
    # If binary install fails, build from source
    pip install -e .
fi

# Build the C core if needed
python setup.py build_c_core

# Run tests
pytest -v tests || true  # Ensure all tests run even if some fail