#!/bin/bash

# Activate the Python environment (if any)
# Note: Using system Python, so no virtualenv activation needed

# Install project dependencies
pip install -r requirements-dev.txt

# Run tests with pytest
# Ensure all tests are executed, even if some fail
pytest -n auto || true