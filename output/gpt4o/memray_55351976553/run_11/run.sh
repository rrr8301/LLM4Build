#!/bin/bash

# Activate virtual environment
source /venv/bin/activate

# Install test dependencies if requirements-test.txt exists
if [ -f "requirements-test.txt" ]; then
    pip install -r requirements-test.txt
fi

# Install the package in development mode if not already done
if [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
    pip install -e .
fi

# Run tests with coverage
set -e  # Exit on errors
export CYTHON_TEST_MACROS=1
export PYTHON=/venv/bin/python
export GENHTMLOPTS="--ignore-errors inconsistent"

# First try make pycoverage, if that fails, fall back to pytest directly
if [ -f "Makefile" ] && grep -q "pycoverage" Makefile; then
    make pycoverage
else
    pytest --cov --cov-report=xml:coverage.xml tests/
fi