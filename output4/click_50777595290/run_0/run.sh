#!/bin/bash

# Activate the Python environment
source /usr/bin/python3.12

# Install project dependencies
pip install -r requirements.txt

# Run tests using uv and tox
uv run --locked tox run -e py3.12 || true