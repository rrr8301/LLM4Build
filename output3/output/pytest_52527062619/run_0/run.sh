#!/bin/bash

# Activate Python environment
source /usr/bin/python3.12

# Install project dependencies
python3.12 -m pip install --upgrade pip
pip install tox coverage

# Run tests with coverage
tox run -e py312-coverage --installpkg `find dist/*.tar.gz`

# Generate coverage report
python3.12 -m coverage xml

# Note: Coverage upload to Codecov is not handled in this script.