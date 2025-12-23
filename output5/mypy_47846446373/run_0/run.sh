#!/bin/bash

# Activate the Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Setup tox environment
tox run -e py --notest || true

# Run tests with tox
tox run -e py --skip-pkg-install -- -n 4 || true

# Ensure all tests are executed, even if some fail
exit 0