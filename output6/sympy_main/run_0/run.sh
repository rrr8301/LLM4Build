#!/bin/bash

# Activate the Python environment
source /usr/bin/activate

# Install project dependencies
pip install -r requirements-dev.txt

# Run tests with pytest, ensuring all tests are executed
pytest -n auto || true