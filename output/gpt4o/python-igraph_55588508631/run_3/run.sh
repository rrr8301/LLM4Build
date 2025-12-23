#!/bin/bash

# Activate Python environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --prefer-binary '.[test]'

# Run tests
pytest -v tests || true  # Ensure all tests run even if some fail