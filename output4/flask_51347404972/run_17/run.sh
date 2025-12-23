#!/bin/bash

# Install project dependencies
pypy3 -m pip install -r examples/celery/requirements.txt

# Run tests
set +e  # Continue on errors
uv run --locked tox -e pypy3.11