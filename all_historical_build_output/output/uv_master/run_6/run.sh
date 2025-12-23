#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies (already done in Dockerfile, so this can be skipped)
# pip install -r requirements.txt

# Build the project
python setup.py build

# Run tests and ensure all tests are executed
pytest --maxfail=0 --disable-warnings

# Note: Coverage upload is ignored due to unsupported action