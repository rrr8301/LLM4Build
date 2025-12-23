#!/bin/bash

# Install project dependencies
python3.12 -m pip install --upgrade pip --root-user-action=ignore

# Check if pyproject.toml exists
if [ ! -f pyproject.toml ]; then
    echo "Error: pyproject.toml not found in /app"
    exit 1
fi

# Install dependencies from pyproject.toml
python3.12 -m pip install . --root-user-action=ignore

# Run tests with tox
set +e  # Continue execution even if some tests fail
tox -e py312 --skip-missing-interpreters false

# Generate coverage report
python3.12 -m coverage xml

# Note: Codecov upload step is ignored as it's not supported outside GitHub Actions