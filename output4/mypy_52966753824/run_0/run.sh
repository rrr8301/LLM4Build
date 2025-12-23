#!/bin/bash

# Activate Python 3.11 environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Setup tox environment
tox run -e py --notest || true

# Run tests
tox run -e py --skip-pkg-install -- -n 4 || true