#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Run the full test suite
set +e  # Continue executing even if some tests fail
python runtests.py

# Run mypy self-check
python runtests.py self

# Run the formatters and linters
python runtests.py lint

# Run tests using tox
tox run -e py

# Run tests using Python 3.11 specifically
tox run -e py311

# Ensure the script exits with a non-zero status if any test fails
set -e