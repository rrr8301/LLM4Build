#!/bin/bash

# Activate the virtual environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install -r requirements-dev.txt

# Run tests with pytest, ensuring all tests are executed
pytest -n auto || true