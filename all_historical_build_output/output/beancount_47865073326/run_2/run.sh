#!/bin/bash

set -e

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -v --no-build-isolation -e .

# Run tests
pytest beancount
meson test -C build/

# Ensure all tests are executed, even if some fail