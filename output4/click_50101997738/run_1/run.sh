#!/bin/bash

# Activate the Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests using uv and tox
uv run --locked tox run -e py311 || true