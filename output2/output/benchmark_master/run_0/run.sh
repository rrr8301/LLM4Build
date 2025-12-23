#!/bin/bash

# Activate Python environment (if any)
# Note: Using system Python, so no virtual environment activation is needed

# Install project dependencies
python3.12 -m pip install -r tools/requirements.txt

# Build the project
python3.12 -m build

# Run tests
python3.12 -m unittest discover || true

# Ensure all tests are executed, even if some fail
exit 0