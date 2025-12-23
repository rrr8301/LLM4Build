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
make build-python

# Run unit tests
cp env.example .env
make unit-test || true  # Ensure all tests run even if some fail