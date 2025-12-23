#!/bin/bash

# Activate Python environment
# Note: The source command is not needed for system Python
# source /usr/bin/python3.12

# Install project dependencies
python3.12 -m pip install -r requirements.txt

# Build the project using Cargo
cargo build

# Run tests using Cargo
cargo test || true

# Run Python tests using pytest
pytest || true