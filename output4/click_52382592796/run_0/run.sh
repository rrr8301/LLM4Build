#!/bin/bash

# Activate Python environment
source /usr/bin/python3.11

# Install project dependencies
pip install -r requirements.txt || true

# Run tests with uv and tox
uv run --locked tox run -e py3.11 || true