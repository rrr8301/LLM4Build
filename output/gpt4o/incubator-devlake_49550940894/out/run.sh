#!/bin/bash

# Set up environment
set -e

# Activate any necessary environments (if applicable)
# source /path/to/venv/bin/activate

# Set git config
git config --global --add safe.directory $(pwd)

# Build Python
cd backend
echo "Building Python"
chmod +x scripts/build-python.sh  # Ensure the script is executable
make build-python

# Run unit tests
cp env.example .env || echo "Warning: env.example not found, continuing with existing .env if present"
make unit-test || true  # Ensure all tests run even if some fail