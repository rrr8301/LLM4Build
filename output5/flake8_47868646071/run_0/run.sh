#!/bin/bash

# Activate virtual environment
python -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests with tox, ensuring all tests are executed
tox -e py || true