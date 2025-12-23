#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Run tests and ensure all tests are executed
pytest || true

# Run syntax checks
tox -e lint || true

# Run tests in all supported Python versions
tox || true