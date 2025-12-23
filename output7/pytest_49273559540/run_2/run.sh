#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the dist directory exists and contains .tar.gz files
if [ ! -d "dist" ] || [ -z "$(ls -A dist/*.tar.gz 2>/dev/null)" ]; then
    echo "Error: No .tar.gz files found in the dist directory. Please ensure the package is built."
    exit 1
fi

# Run tests
set +e  # Continue on errors
tox -e py310-xdist --installpkg $(find dist/*.tar.gz)

# Generate coverage report if needed
# python -m coverage xml

# Placeholder for uploading coverage to Codecov
# echo "Upload coverage report to Codecov manually"