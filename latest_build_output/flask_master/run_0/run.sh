#!/bin/bash

# Activate Python environment
source /usr/bin/python3.12

# Install project dependencies
pip install -r examples/celery/requirements.txt

# Run tests
set +e  # Continue on errors
uv run --locked tox run -e py3.12