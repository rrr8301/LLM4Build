#!/bin/bash

set -e

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -v --no-build-isolation -Cbuild-dir=build -Csetup-args=-Dtests=enabled -e .

# Run tests
pytest beancount || true
meson test -C build/ || true

# Ensure all tests are executed, even if some fail