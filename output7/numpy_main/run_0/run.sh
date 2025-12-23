#!/bin/bash

# Activate the environment (if any virtual environment is used, otherwise skip)
# source /path/to/venv/bin/activate

# Install project dependencies
pip3 install --no-cache-dir .

# Run tests
# Ensure all tests are executed, even if some fail
pytest || true