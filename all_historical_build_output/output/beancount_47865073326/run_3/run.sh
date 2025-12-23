#!/bin/bash

set -e

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Upgrade pip and install mesonpy in the virtual environment
pip install --upgrade pip
pip install mesonpy

# Install project dependencies
pip install -v --no-build-isolation -e .

# Run tests
pytest beancount
meson test -C build/

# Ensure all tests are executed, even if some fail