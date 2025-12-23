#!/bin/bash

# Create and activate Python virtual environment
python3.12 -m venv /app/venv
source /app/venv/bin/activate

# Install project dependencies
pip install -r examples/celery/requirements.txt

# Run tests
set +e  # Continue on errors
uv run --locked tox run -e py3.12