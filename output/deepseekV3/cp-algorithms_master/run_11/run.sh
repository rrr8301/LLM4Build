#!/bin/bash

# Exit immediately if any command fails
set -e

# Set TERM environment variable if not set
export TERM=${TERM:-xterm}

# Install any additional requirements if needed
if [ -f "preview/requirements.txt" ]; then
    echo "Installing requirements..."
    # First ensure setuptools and packaging are available
    pip install --upgrade --root-user-action=ignore pip setuptools packaging
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
    # Check if extract_snippets.py exists in either root, preview or test directory
    if [ ! -f "extract_snippets.py" ] && [ ! -f "preview/extract_snippets.py" ] && [ ! -f "test/extract_snippets.py" ]; then
        echo "Error: extract_snippets.py not found in root, preview or test directory - this file is required for tests"
        exit 1
    fi
    # Check if any .cpp files exist before running C++ tests
    if [ -z "$(find . -name '*.cpp' -print -quit)" ]; then
        echo "Warning: No .cpp files found - skipping C++ compilation tests"
        # Run tests without C++ compilation
        TERM=xterm ./test/test.sh || { echo "Some tests failed"; exit 1; }
    else
        # Run all tests normally
        TERM=xterm ./test/test.sh || { echo "Some tests failed"; exit 1; }
    fi
else
    echo "Error: test/test.sh not found"
    exit 1
fi

echo "Test execution completed"