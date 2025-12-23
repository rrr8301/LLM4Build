#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Install the project in editable mode
pip install . --no-deps

# List installed packages for verification
pip list | grep 'astroid\|pylint'

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
python -m pytest --durations=10 --benchmark-disable --cov --cov-report= tests/
python -m pytest -vv --minimal-messages-config tests/test_functional.py --benchmark-disable
set -e  # Re-enable exit on error