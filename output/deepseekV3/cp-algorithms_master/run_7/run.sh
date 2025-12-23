#!/bin/bash

# Exit immediately if any command fails
set -e

# Set TERM environment variable if not set
export TERM=${TERM:-xterm}

# Install any additional requirements if needed
if [ -f "preview/requirements.txt" ]; then
    echo "Installing requirements..."
    # First ensure setuptools is available
    pip install --upgrade --root-user-action=ignore pip setuptools
    # Fix any potential formatting issues in requirements
    sed -i 's/watchdog==2.1./watchdog==2.1/' preview/requirements.txt
    # Validate requirements format first using modern alternative
    python -c "from packaging.requirements import Requirement; [Requirement(line.strip()) for line in open('preview/requirements.txt') if line.strip() and not line.strip().startswith('#')]"
    pip install --no-cache-dir --root-user-action=ignore -r preview/requirements.txt
fi

# Run tests with error handling
echo "Running test suite..."

# Check if test script exists and run it
if [ -f "test/test.sh" ]; then
    chmod +x test/test.sh
    # Check if extract_snippets.py exists before running tests
    if [ ! -f "extract_snippets.py" ]; then
        echo "Warning: extract_snippets.py not found, some tests may fail"
    fi
    # Run tests with TERM environment variable set
    TERM=xterm ./test/test.sh
else
    echo "Error: test/test.sh not found"
    exit 1
fi

echo "Test execution completed"