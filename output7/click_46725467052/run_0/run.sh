#!/bin/bash

# Activate the Python virtual environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests using uv and tox
uv run --locked tox run -e py3.11 || true

# Ensure all tests are executed, even if some fail
set +e
tox || true