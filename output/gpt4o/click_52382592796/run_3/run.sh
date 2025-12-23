#!/bin/bash

# Exit on any error
set -e

# Create and activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Upgrade pip to latest version
pip install --upgrade pip

# Install uv and tox in the virtual environment
pip install uv tox

# Install project dependencies using uv (without --system flag)
uv pip install -e .

# Run tests with tox
set +e  # Continue execution even if some tests fail
tox run -e py3.11