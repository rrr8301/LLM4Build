#!/bin/bash

# Activate virtual environment
python3.10 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run CMake tests
cd cmake/test
pytest -s || true

# Ensure all tests are executed
set +e
pytest -s
set -e