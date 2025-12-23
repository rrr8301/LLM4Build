#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Create a virtual environment to avoid running pip as root
python3.11 -m venv venv
source venv/bin/activate

# Upgrade pip and install project dependencies
python3.11 -m pip install --upgrade pip
pip install -r doc/en/requirements.txt

# Build the package
if [ -f setup.py ]; then
    python3.11 setup.py sdist
else
    echo "setup.py not found in the current directory"
    exit 1
fi

# Run tests with coverage
set +e  # Continue execution even if some tests fail
tox -e py311
python3.11 -m coverage xml

# Note: Uploading coverage to Codecov is not supported in this script.
# Please upload the coverage.xml file manually if needed.