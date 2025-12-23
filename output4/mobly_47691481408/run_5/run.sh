#!/bin/bash

# Install project dependencies
pip install --no-cache-dir -e .

# Run tests with tox
tox || true

# Check formatting
pyink --check . || true