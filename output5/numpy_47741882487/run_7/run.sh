#!/bin/bash

# Activate the Python environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install -r requirements.txt || true  # Assuming a requirements.txt exists

# Ensure the current directory is not in the Python path to avoid local imports
export PYTHONPATH="/app/venv/lib/python3.10/site-packages"

# Temporarily move the local numpy directory to avoid import conflicts
if [ -d "/app/numpy" ]; then
    mv /app/numpy /app/numpy_local
fi

# Run the custom meson actions
./.github/meson_actions || true  # Assuming this is a script or executable

# Run tests
pytest --disable-warnings  # Run all tests without skipping

# Move the local numpy directory back
if [ -d "/app/numpy_local" ]; then
    mv /app/numpy_local /app/numpy
fi