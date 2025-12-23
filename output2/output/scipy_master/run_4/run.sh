#!/bin/bash

# Create and activate Python virtual environment
python3.12 -m venv /app/venv
source /app/venv/bin/activate

# Install project dependencies (if any additional are needed)
# python3.12 -m pip install -r requirements.txt

# Build the project
spin build --werror

# Set environment variables
export OMP_NUM_THREADS=2

# Run tests
spin test -j3 -- --durations 10 --timeout=60 || true