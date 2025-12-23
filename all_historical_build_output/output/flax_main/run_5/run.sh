#!/bin/bash

# Activate the Python environment (if any virtual environment is used)
# source venv/bin/activate

# Install project dependencies
pip3 install .

# Run tests
# Assuming tests are run using pytest
pytest --tb=short --disable-warnings tests || exit 1  # Run all tests without skipping