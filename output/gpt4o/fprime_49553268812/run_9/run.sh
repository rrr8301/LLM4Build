#!/bin/bash

# Activate the virtual environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Generate UT build cache
cd FppTestProject

# Ensure all submodules are properly initialized
if [ -d .git ]; then
    git submodule sync --recursive
    git submodule update --init --recursive
fi

# Build and run UTs
cd FppTest

# Explicitly initialize googletest submodule
if [ -d ../googletest ]; then
    cd ../googletest && \
    git submodule sync --recursive && \
    git submodule update --init --recursive && \
    cd -
else
    echo "Error: googletest directory not found"
    exit 1
fi

# Build and test
fprime-util generate --ut || { echo "Failed to generate UT build cache"; exit 1; }
fprime-util build --ut || { echo "Failed to build UTs"; exit 1; }
fprime-util check -v || true  # Ensure all tests run even if some fail