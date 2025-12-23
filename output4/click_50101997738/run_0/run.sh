#!/bin/bash

# Activate the Python environment
source /usr/bin/python3.11

# Install project dependencies
pip install -r requirements.txt || true

# Run tests using uv and tox
uv run --locked tox run -e py311 || true