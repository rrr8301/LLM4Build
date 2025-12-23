#!/bin/bash

# Activate any necessary environments (if applicable)
# Assuming virtual environments are not used here

# Install project dependencies
pip3 install -r requirements.txt

# Generate UT build cache
cd FppTestProject
fprime-util generate --ut

# Build UTs
cd FppTest
fprime-util build --ut

# Run UTs
fprime-util check || true  # Ensure all tests run even if some fail