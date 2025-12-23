#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# Example: source /path/to/venv/bin/activate

# Install project dependencies
pypy3 -m pip install -r requirements.txt || true

# Run tests
uv run --locked tox run -e pypy3.11 || true