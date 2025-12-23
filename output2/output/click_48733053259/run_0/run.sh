#!/bin/bash

# Activate Python environment
python3.10 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --no-cache-dir -r requirements.txt

# Run tests with uv and tox
set +e  # Continue execution even if some tests fail
uv run --locked tox run -e py3.10