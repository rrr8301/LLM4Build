#!/bin/bash

# Activate the virtual environment
source /opt/venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests using tox
set +e
tox -e py3.11