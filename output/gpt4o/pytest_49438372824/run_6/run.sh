#!/bin/bash

# Create and activate Python virtual environment
python3.11 -m venv /app/venv
source /app/venv/bin/activate

# Upgrade pip in the virtual environment
python -m pip install --upgrade pip

# Install project dependencies
if [ -f "/app/requirements.txt" ]; then
    pip install -r /app/requirements.txt
else
    echo "Warning: requirements.txt not found, skipping dependency installation"
fi

# Build the package if dist directory is empty
if [ ! -d "/app/dist" ] || [ -z "$(ls -A /app/dist)" ]; then
    python -m pip install build
    # Set version explicitly for setuptools-scm
    if [ -z "$SETUPTOOLS_SCM_PRETEND_VERSION" ]; then
        export SETUPTOOLS_SCM_PRETEND_VERSION=0.0.1
    fi
    python -m build --no-isolation
fi

# Find the built package
PACKAGE=$(find /app/dist -name '*.tar.gz' | head -n 1)

# Run tests with coverage if package exists
if [ -n "$PACKAGE" ]; then
    tox run -e py311-coverage --installpkg "$PACKAGE"
else
    echo "Error: No package found in dist directory"
    exit 1
fi

# Generate coverage report
python -m coverage xml

# Placeholder for manual Codecov upload
echo "Upload coverage report to Codecov manually."