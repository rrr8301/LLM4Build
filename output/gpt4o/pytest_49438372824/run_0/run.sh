#!/bin/bash

# Activate Python environment
source /usr/bin/python3.11

# Install project dependencies
pip install -r requirements.txt

# Run tests with coverage
tox run -e py311-coverage --installpkg `find dist/*.tar.gz`

# Generate coverage report
python -m coverage xml

# Placeholder for manual Codecov upload
echo "Upload coverage report to Codecov manually."