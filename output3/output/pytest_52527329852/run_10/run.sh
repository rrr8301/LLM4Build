#!/bin/bash

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Set a pretend version for setuptools-scm
# Replace 'project_name' with the actual normalized distribution name
export SETUPTOOLS_SCM_PRETEND_VERSION_FOR_project_name=0.1.0

# Install project dependencies
pip install --upgrade pip
pip install tox coverage build setuptools-scm

# Build the package
python -m build

# Check if the package was built successfully
if [ ! -f dist/*.tar.gz ]; then
    echo "Package build failed. Exiting."
    exit 1
fi

# Run tests with coverage
set +e  # Continue on errors
tox -e py311 --installpkg $(find dist/*.tar.gz)
set -e

# Generate coverage report
python -m coverage xml

# Placeholder for manual Codecov upload
echo "Upload coverage report manually or implement an alternative method."