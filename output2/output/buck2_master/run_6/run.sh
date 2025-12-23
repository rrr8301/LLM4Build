#!/bin/bash

# Activate the Python environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Build the project
if [ -f setup.py ]; then
    python setup.py build
else
    echo "setup.py not found, skipping build step."
fi

# Run tests and ensure all tests are executed
python -m unittest discover