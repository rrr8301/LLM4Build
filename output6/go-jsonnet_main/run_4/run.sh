#!/bin/bash

set -e

# Activate Python environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --no-cache-dir -r requirements.txt

# Build source distribution
python3 -m build --sdist

# Run tests
make test

# Deactivate the environment
deactivate