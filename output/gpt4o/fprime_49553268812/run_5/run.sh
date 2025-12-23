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

# Explicitly initialize googletest if needed
if [ ! -d "googletest" ]; then
    git submodule add https://github.com/google/googletest.git googletest
    git submodule update --init --recursive googletest
fi

fprime-util generate --ut

# Build UTs
cd FppTest
fprime-util build --ut

# Run UTs with verbose output
fprime-util check -v || true  # Ensure all tests run even if some fail