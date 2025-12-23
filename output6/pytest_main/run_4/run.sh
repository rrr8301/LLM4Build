#!/bin/bash

# Activate Python environment (if any virtual environment is used)
# source /path/to/venv/bin/activate

# Install project dependencies
python3.12 -m pip install --upgrade pip
pip install tox coverage

# Check if setup.py exists
if [ ! -f setup.py ]; then
    echo "Error: setup.py not found in /app"
    exit 1
fi

# Build the package
python3.12 setup.py sdist

# Run tests
set +e  # Continue execution even if some tests fail
tox -e py312

# Generate coverage report
python3.12 -m coverage xml

# Note: Codecov upload step is ignored as it's not supported outside GitHub Actions