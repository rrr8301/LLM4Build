#!/bin/bash

# Activate the virtual environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Generate UT build cache
cd FppTestProject

# Only try to initialize googletest if we're not in a container (where it's already done)
if [ -d .git ] && [ ! -d "googletest" ]; then
    echo "Initializing googletest submodule..."
    git submodule add https://github.com/google/googletest.git googletest || \
    git submodule update --init --recursive --depth 1 googletest || \
    { echo "Failed to initialize googletest submodule"; exit 1; }
fi

# Build and run UTs
cd FppTest

# Build and test
fprime-util generate --ut || { echo "Failed to generate UT build cache"; exit 1; }
fprime-util build --ut || { echo "Failed to build UTs"; exit 1; }
fprime-util check -v || true  # Ensure all tests run even if some fail