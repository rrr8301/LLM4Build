#!/bin/bash

# Install project dependencies
pip install -e .

# Run tests with tox
tox || true

# Check formatting
pyink --check . || true