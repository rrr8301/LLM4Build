#!/bin/bash

# Create and activate the Python virtual environment
python3 -m venv venv
source venv/bin/activate

# Upgrade pip inside the virtual environment
pip install --upgrade pip

# Install project dependencies
pip install -r requirements-dev.txt

# Run tests with pytest, ensuring all tests are executed
pytest -n auto || true