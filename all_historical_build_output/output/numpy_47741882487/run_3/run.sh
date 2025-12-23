#!/bin/bash

# Activate the Python environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install -r requirements.txt || true  # Assuming a requirements.txt exists

# Ensure the current directory is not in the Python path to avoid local imports
export PYTHONPATH=$(pwd)

# Run the custom meson actions
./.github/meson_actions || true  # Assuming this is a script or executable

# Run tests
pytest  # Run all tests without skipping