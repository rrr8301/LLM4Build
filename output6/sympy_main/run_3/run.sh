#!/bin/bash

# Create and activate the Python virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements-dev.txt

# Run tests with pytest, ensuring all tests are executed
pytest -n auto || true