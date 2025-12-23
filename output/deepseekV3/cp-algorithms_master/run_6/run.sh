#!/bin/bash

# Exit immediately if any command fails
set -e

# Install any additional requirements if needed
if [ -f "preview/requirements.txt" ]; then
    echo "Installing requirements..."
    # First ensure setuptools is available
    pip install --upgrade pip setuptools
    # Fix any potential formatting issues in requirements
    sed -i 's/watchdog==2.1./watchdog==2.1/' preview/requirements.txt
    # Validate requirements format first
    python -c "import pkg_resources; pkg_resources.parse_requirements(open('preview/requirements.txt'))"
    pip install --no-cache-dir -r preview/requirements.txt
fi

# Run tests with error handling
echo "Running test suite..."

# Check if test script exists and run it
if [ -f "test/test.sh" ]; then
    chmod +x test/test.sh
    ./test/test.sh
else
    echo "Error: test/test.sh not found"
    exit 1
fi

echo "Test execution completed"