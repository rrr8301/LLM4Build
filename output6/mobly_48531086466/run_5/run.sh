#!/bin/bash

# Install project dependencies
pip install -e .

# Run tests with tox
tox  # Ensure all tests run

# Check formatting
pyink --check .  # Ensure formatting check runs