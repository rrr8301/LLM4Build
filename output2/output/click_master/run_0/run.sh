#!/bin/bash

# Activate the Python environment
source /app/venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests using uv and tox
set +e  # Continue execution even if some tests fail
uv run --locked tox run -e py3.11