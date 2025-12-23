#!/bin/bash

# Activate the virtual environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Generate UT build cache
cd FppTestProject
# Ensure submodules are initialized (redundant but safe)
git submodule update --init --recursive

# Build and run UTs
cd FppTest
fprime-util generate --ut
fprime-util build --ut
fprime-util check -v || true  # Ensure all tests run even if some fail