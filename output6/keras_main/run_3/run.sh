#!/bin/bash

# run.sh

# Activate virtual environment if needed (not used here as system Python is used)

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
pytest keras --cov=keras --cov-config=pyproject.toml
coverage xml -o coverage.xml
set -e  # Re-enable exit on error