#!/bin/bash

# Create and activate Python virtual environment
python3.12 -m venv /app/venv
source /app/venv/bin/activate

# Upgrade pip in the virtual environment
python3.12 -m pip install --upgrade pip setuptools wheel

# Install distutils in the virtual environment
python3.12 -m pip install distutils

# Install project dependencies (if any additional are needed)
if [ -f requirements.txt ]; then
    python3.12 -m pip install -r requirements.txt
fi

# Build the project
spin build --werror

# Set environment variables
export OMP_NUM_THREADS=2

# Run tests
spin test -j3 -- --durations 10 --timeout=60 || true