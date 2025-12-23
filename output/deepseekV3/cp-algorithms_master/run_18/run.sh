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
    # Ensure extract_snippets.py is available in root directory
    if [ ! -f "extract_snippets.py" ] && [ -f "test/extract_snippets.py" ]; then
        echo "Copying extract_snippets.py from test directory to root..."
        cp test/extract_snippets.py .
    fi
    
    # Check for C++ files in test directory
    if [ -n "$(find test -name '*.cpp')" ]; then
        echo "Found C++ test files"
        # Compile each C++ file individually with include paths
        for cpp_file in test/*.cpp; do
            echo "Compiling $cpp_file..."
            g++ -I. -Iinclude -I/usr/local/include -I/app -I/app/include "$cpp_file" -o "${cpp_file%.*}" || { echo "Compilation failed for $cpp_file"; exit 1; }
        done
    else
        echo "Warning: No C++ test files found in test directory"
    fi
    
    # Run all tests normally
    TERM=xterm ./test/test.sh || { echo "Some tests failed"; exit 1; }
else
    echo "Error: test/test.sh not found"
    exit 1
fi

echo "Test execution completed"