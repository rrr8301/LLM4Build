#!/bin/bash

# Ensure the script exits on any error
set -e

# Install project dependencies
python3.11 -m pip install --upgrade pip
pip install tox coverage

# Build the package if not already present
if [ ! -d "dist" ]; then
    python3.11 setup.py sdist
fi

# Run tests with coverage
tox -e py311-coverage --installpkg `find dist/*.tar.gz`

# Generate coverage report
python3.11 -m coverage xml

# Placeholder for manual Codecov upload
echo "Upload coverage report manually or implement an alternative method."