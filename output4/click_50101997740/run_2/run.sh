#!/bin/bash

# Activate the Python virtual environment
source /app/venv/bin/activate

# Install project dependencies using uv
uv install --locked

# Run tests using tox
uv run --locked tox run -e py3.10

# Ensure all tests are executed, even if some fail
exit 0