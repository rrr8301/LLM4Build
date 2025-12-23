#!/bin/bash

# Activate the Python environment (if any)
# Assuming uv handles environment activation

# Install project dependencies
uv pip install --system -e ".[test]"

# Run tests with coverage
set +e  # Ensure all tests run even if some fail
python -m xonsh run-tests.xsh test --report-coverage -- --timeout=240