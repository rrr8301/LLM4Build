#!/bin/bash

# Activate environment (if any virtual environment is used, activate it here)

# Install project dependencies
python3.12 -m pip install --upgrade git+https://github.com/ipython/matplotlib-inline.git@main

# Run tests
pytest --color=yes -raXxs --cov --cov-report=xml --maxfail=15 || true

# Note: Coverage upload to Codecov is not handled in this script.