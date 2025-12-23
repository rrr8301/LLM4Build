#!/bin/bash

# Exit on any error
set -e

# Create and activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Upgrade pip to latest version
pip install --upgrade pip

# Install uv in the virtual environment
pip install uv

# Install project dependencies using uv
uv pip install -e .

# Run tests directly with uv instead of tox
uv run pytest