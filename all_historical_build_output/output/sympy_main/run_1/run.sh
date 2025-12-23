#!/bin/bash

# Activate the environment (if any virtual environment is used)
# source /path/to/venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests
# Ensure all tests are executed, even if some fail
set +e
python setup.py test
set -e