#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if setup.py exists
if [ ! -f "setup.py" ]; then
    echo "Error: setup.py not found. Cannot build the package."
    exit 1
fi

# Build the package if the dist directory does not contain .tar.gz files
if [ ! -d "dist" ] || [ -z "$(ls -A dist/*.tar.gz 2>/dev/null)" ]; then
    echo "No .tar.gz files found in the dist directory. Building the package..."
    python3 setup.py sdist
fi

# Check again if the dist directory contains .tar.gz files
if [ ! -d "dist" ] || [ -z "$(ls -A dist/*.tar.gz 2>/dev/null)" ]; then
    echo "Error: Failed to build the package. No .tar.gz files found in the dist directory."
    exit 1
fi

# Run tests
set +e  # Continue on errors
tox -e py310-xdist --installpkg $(find dist/*.tar.gz)

# Generate coverage report if needed
# python -m coverage xml

# Placeholder for uploading coverage to Codecov
# echo "Upload coverage report to Codecov manually"