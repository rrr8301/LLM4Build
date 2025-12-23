#!/bin/bash

# Activate the virtual environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Initialize and update all submodules recursively
git submodule update --init --recursive || { echo "Failed to initialize submodules"; exit 1; }

# Ensure all submodules are properly initialized (including nested ones)
cd /app/FppTestProject && git submodule update --init --recursive
cd /app/FppTestProject/FppTest && git submodule update --init --recursive
cd /app/FppTestProject/FppTest/googletest && git submodule update --init --recursive

# Generate UT build cache
cd /app/FppTestProject/FppTest

# Build and test
fprime-util generate --ut || { echo "Failed to generate UT build cache"; exit 1; }
fprime-util build --ut || { echo "Failed to build UTs"; exit 1; }
fprime-util check -v || true  # Ensure all tests run even if some fail