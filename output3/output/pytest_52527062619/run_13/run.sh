#!/bin/bash

# Ensure the correct Python version is used
PYTHON=python3.12

# Upgrade pip and install setuptools and distutils via pip
$PYTHON -m pip install --upgrade pip
$PYTHON -m pip install setuptools
$PYTHON -m pip install distutils

# Install project dependencies
$PYTHON -m pip install tox coverage

# Run tests with coverage
tox -e py312-coverage --installpkg $(find dist/*.tar.gz)

# Generate coverage report
$PYTHON -m coverage xml

# Note: Coverage upload to Codecov is not handled in this script.