#!/bin/bash

# Activate the Python environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests with tox, ensuring all tests are executed
set +e
uv run --locked tox run -e py3.12
set -e