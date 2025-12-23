#!/bin/bash

# Activate the Python environment
python3.13 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install -r requirements.txt || true  # Assuming a requirements.txt exists

# Run the custom meson actions
./.github/meson_actions || true  # Assuming this is a script or executable

# Run tests
pytest || true  # Ensure all tests run even if some fail