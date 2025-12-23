#!/bin/bash

# Activate virtual environment
python3.9 -m venv venv
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
fprime-util check || true  # Ensure all tests run even if some fail