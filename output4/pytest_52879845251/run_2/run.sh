#!/bin/bash

# Ensure the script exits on any error
set -e

# Install project dependencies
python3.11 -m pip install --upgrade pip
pip install tox coverage

# Check if setup.py exists and build the package if not already present
if [ -f "setup.py" ]; then
    if [ ! -d "dist" ]; then
        python3.11 setup.py sdist
    fi
else
    echo "Error: setup.py not found. Please ensure it exists in the project root."
    exit 1
fi

# Run tests with coverage
tox -e py311-coverage --installpkg `find dist/*.tar.gz`

# Generate coverage report
python3.11 -m coverage xml

# Placeholder for manual Codecov upload
echo "Upload coverage report manually or implement an alternative method."