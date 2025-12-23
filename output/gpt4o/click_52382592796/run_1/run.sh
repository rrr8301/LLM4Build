#!/bin/bash

# Exit on any error
set -e

# Create and activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Upgrade pip to latest version
pip install --upgrade pip

# Install project dependencies
pip install -r requirements.txt

# Run tests with uv and tox
set +e  # Continue execution even if some tests fail
uv run --locked tox run -e py3.11