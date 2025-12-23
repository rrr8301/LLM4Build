#!/bin/bash

# Activate Python environment (if any specific activation is needed, otherwise skip)
# source /path/to/venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Setup tox environment
tox run -e py --notest || true

# Run tests
tox run -e py --skip-pkg-install -- -n 4 || true