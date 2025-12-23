#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# source /path/to/venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests
tox -e pypy3 || echo "Tox tests failed. Please check the configuration."

# If specific tox configuration is needed, ensure pyproject.toml is set up correctly
if [ ! -f pyproject.toml ]; then
    echo "[tool.tox]" > pyproject.toml
    echo "envlist = pypy3" >> pyproject.toml
fi