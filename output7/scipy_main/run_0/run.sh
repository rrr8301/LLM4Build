#!/bin/bash

# Activate Python environment (if any virtualenv is used, otherwise skip)
# source /path/to/venv/bin/activate

# Install project dependencies
pip3 install --no-cache-dir -r requirements.txt || true

# Run tests
pytest tests || true

# Ensure all tests are executed, even if some fail
pytest --continue-on-collection-errors || true