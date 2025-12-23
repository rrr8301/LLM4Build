#!/bin/bash

# Activate Python environment (if any specific activation is needed)
# For now, we assume the default Python environment is used

# Create a virtual environment to avoid running pip as root
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
python3.11 -m pip install --upgrade pip
pip install tox coverage

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