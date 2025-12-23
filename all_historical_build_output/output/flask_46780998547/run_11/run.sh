#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the Python environment
python3.11 -m venv venv
source venv/bin/activate

# Upgrade pip to the latest version
pip install --upgrade pip

# Install project dependencies
if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi

# Install tox inside the virtual environment
pip install tox

# Run tests
tox -e py311