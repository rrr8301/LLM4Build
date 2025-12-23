#!/bin/bash

# Activate the Python virtual environment
source /app/venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests using uv and tox
uv run --locked tox run -e py3.12 || true