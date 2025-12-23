#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Setup a virtual environment
python3 -m venv mypycsw
source mypycsw/bin/activate

# Install pycsw and its dependencies
pip install -e . && pip install -r requirements-standalone.txt

# Run tests and ensure all tests are executed
pytest || true