#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
python setup.py build

# Run tests and ensure all tests are executed
pytest --maxfail=0 --disable-warnings