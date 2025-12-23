#!/bin/bash

# Activate the Python environment (if any virtual environment is used)
# source venv/bin/activate

# Install project dependencies
pip3 install -e .

# Run tests
# Assuming tests are run using pytest
pytest tests  # Run all tests without skipping