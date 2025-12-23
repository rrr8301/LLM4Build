#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# Example: source /path/to/venv/bin/activate

# Install project dependencies
pypy3 -m pip install -r examples/celery/requirements.txt

# Run tests
set +e  # Continue on errors
uv run --locked tox -e pypy3.11