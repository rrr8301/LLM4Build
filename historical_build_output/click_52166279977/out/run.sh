#!/bin/bash

# Activate Python environment
source /app/venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests
set +e  # Continue executing even if some tests fail
uv run --locked tox run -e py3.11