#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Create and activate a virtual environment
python3 -m venv venv
source venv/bin/activate

# Install flake8 from source
git clone https://github.com/PyCQA/flake8.git
cd flake8
pip install -e .
cd ..

# Check if test-requirements.txt exists
if [ -f "test-requirements.txt" ]; then
    # Install test dependencies
    pip install -r test-requirements.txt
else
    echo "Error: test-requirements.txt not found."
    exit 1
fi

# Run the test suite
pytest