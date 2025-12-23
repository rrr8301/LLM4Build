#!/bin/bash

# Activate the Python environment (if any specific environment is needed, set it up here)

# Install project dependencies
pip3 install -r requirements-dev.txt

# Run tests with pytest, ensuring all tests are executed
pytest -n auto || true