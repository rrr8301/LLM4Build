#!/bin/bash

# Install project dependencies
pypy3 -m pip install --no-cache-dir -r examples/celery/requirements.txt

# Run tests
set +e  # Continue on errors
uv run --locked tox run -e pypy3.11