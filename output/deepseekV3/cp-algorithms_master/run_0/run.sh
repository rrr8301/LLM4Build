#!/bin/bash

# Activate any virtual environment if needed (not required for system Python)
# source venv/bin/activate

# Install project dependencies (already done in Dockerfile, but can be repeated)
pip install -e .

# Run tests
# Use set -e to ensure script exits on error, but run tests with || true to continue on failure
set -e
echo "Running test suite..."
./test.sh || true

# Additional test commands if needed
# pytest tests/ || true

echo "Test execution completed"