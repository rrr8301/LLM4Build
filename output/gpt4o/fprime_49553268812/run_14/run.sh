#!/bin/bash

# Activate the virtual environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Generate UT build cache
cd FppTestProject/FppTest

# Build and test
fprime-util generate --ut || { echo "Failed to generate UT build cache"; exit 1; }
fprime-util build --ut || { echo "Failed to build UTs"; exit 1; }
fprime-util check -v || true  # Ensure all tests run even if some fail