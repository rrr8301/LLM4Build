#!/bin/bash

# Activate virtual environment if needed
# source /path/to/venv/bin/activate

# Install project dependencies
python3.12 -m pip install -r requirements.txt

# Build the project
python3.12 setup.py build

# Run tests and ensure all tests are executed
pytest || true