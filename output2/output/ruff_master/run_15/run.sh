#!/bin/bash

# Activate virtual environment if needed
# source /path/to/venv/bin/activate

# Build the project
python3.12 setup.py build

# Run tests and ensure all tests are executed
pytest