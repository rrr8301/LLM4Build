# run.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Python environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install -e .

# Run tests with tox
tox  # Run all tests without skipping

# Check formatting
pyink --check .  # Run formatting check without skipping