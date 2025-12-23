#!/bin/bash

# Create and activate Python virtual environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests
uv run --locked tox run -e py3.11 || true