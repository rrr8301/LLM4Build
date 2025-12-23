#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Create and activate a virtual environment
python3 -m venv venv
source venv/bin/activate

# Install flake8 from source
git clone https://github.com/PyCQA/flake8.git
cd flake8
pip install -e .
cd ..

# Install test dependencies
pip install -r test-requirements.txt

# Run the test suite
# Ensure all tests are executed, even if some fail
pytest || true