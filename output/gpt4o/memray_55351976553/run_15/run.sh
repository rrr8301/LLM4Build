#!/bin/bash

# Activate virtual environment
source /venv/bin/activate

# Install test dependencies if requirements-test.txt exists
if [ -f "requirements-test.txt" ]; then
    pip install -r requirements-test.txt
fi

# Install the package in development mode if not already done
if [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
    pip install -e .[test]
fi

# Run tests with coverage
set -e  # Exit on errors
export CYTHON_TEST_MACROS=1
export PYTHON=/venv/bin/python
export GENHTMLOPTS="--ignore-errors inconsistent"

# First try make pycoverage, if that fails, fall back to pytest directly
if [ -f "Makefile" ]; then
    if grep -q "pycoverage" Makefile; then
        make pycoverage || (echo "make pycoverage failed, falling back to pytest" && pytest --cov --cov-report=xml:coverage.xml tests/)
    elif grep -q "test" Makefile; then
        make test || (echo "make test failed, falling back to pytest" && pytest --cov --cov-report=xml:coverage.xml tests/)
    else
        pytest --cov --cov-report=xml:coverage.xml tests/
    fi
else
    pytest --cov --cov-report=xml:coverage.xml tests/
fi

# Ensure tests were actually run
if [ ! -f "coverage.xml" ]; then
    echo "Error: Tests were not run or coverage.xml was not generated"
    exit 1
fi