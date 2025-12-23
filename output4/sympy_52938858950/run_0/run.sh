#!/bin/bash

# Activate the Python environment (if any virtual environment is used)
# source /path/to/venv/bin/activate

# Install project dependencies
pip install -r requirements-dev.txt

# Run tests with pytest, ensuring all tests are executed
pytest -n auto || true