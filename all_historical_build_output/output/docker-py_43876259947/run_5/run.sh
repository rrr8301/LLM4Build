#!/bin/bash

# Activate virtual environment if needed (not used here, but placeholder for future use)
# source venv/bin/activate

# Run tests
set -e
set -o pipefail

# Run unit tests and ensure all tests are executed
pytest -v --cov=docker tests/unit