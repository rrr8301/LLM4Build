#!/bin/bash

# Activate the Python environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Build the project
python setup.py build

# Run tests and ensure all tests are executed
python -m unittest discover