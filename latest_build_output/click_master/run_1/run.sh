#!/bin/bash

# Create and activate a Python virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests with uv and tox
uv run --locked tox run -e py3.12 || true