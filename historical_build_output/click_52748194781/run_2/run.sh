#!/bin/bash

# Activate Python virtual environment
source /app/venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests
uv run --locked tox run -e py3.11 || true