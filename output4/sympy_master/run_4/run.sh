#!/bin/bash

# Activate the virtual environment
source /app/venv/bin/activate

# Install project dependencies
pip install -r requirements-dev.txt

# Run tests with pytest, ensuring all tests are executed
pytest -n auto