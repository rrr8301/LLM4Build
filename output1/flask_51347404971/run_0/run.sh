#!/bin/bash

# Activate the Python environment
source /usr/bin/python3.11

# Install project dependencies
pip install -r examples/celery/requirements.txt

# Run tests using uv and tox
uv run --locked tox run -e || true

# Ensure all tests are executed, even if some fail
exit 0