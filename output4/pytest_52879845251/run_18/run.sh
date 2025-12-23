#!/bin/bash

# Ensure the script exits on any error
set -e

# Activate the virtual environment
source /app/venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install tox coverage

# Check if setup.py exists and build the package if not already present
if [ -f "setup.py" ]; then
    # Create dist directory if it doesn't exist
    mkdir -p dist
    if [ -z "$(ls -A dist)" ]; then
        python setup.py sdist
    fi
else
    echo "Error: setup.py not found. Exiting."
    exit 1
fi

# Run tests with coverage
if [ -d "dist" ]; then
    tox -e py311 --installpkg $(find dist/*.tar.gz)
else
    echo "Error: No distribution package found. Ensure setup.py is present and build the package."
    exit 1
fi

# Generate coverage report
python -m coverage xml

# Placeholder for manual Codecov upload
echo "Upload coverage report manually or implement an alternative method."