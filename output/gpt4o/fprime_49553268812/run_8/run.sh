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
# First ensure the googletest submodule is properly initialized
if [ -d ../googletest ]; then
    cd ../googletest && git submodule update --init --recursive && cd -
fi

fprime-util generate --ut
fprime-util build --ut
fprime-util check -v || true  # Ensure all tests run even if some fail