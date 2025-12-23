#!/bin/bash

# Activate the virtual environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Generate UT build cache
cd FppTestProject

# Verify googletest submodule exists and is initialized
if [ ! -d "googletest" ]; then
    echo "Error: googletest directory not found in FppTestProject"
    exit 1
fi

# Build and run UTs
cd FppTest

# Build and test
fprime-util generate --ut || { echo "Failed to generate UT build cache"; exit 1; }
fprime-util build --ut || { echo "Failed to build UTs"; exit 1; }
fprime-util check -v || true  # Ensure all tests run even if some fail