#!/bin/bash

set -e

# Activate virtual environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Generate UT build cache
cd FppTestProject
fprime-util generate --ut

# Build UTs
cd FppTest
fprime-util build --ut

# Run UTs
set +e  # Ensure all tests run even if some fail
fprime-util check
set -e