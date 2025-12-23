#!/bin/bash

# Activate the environment (if any virtual environment is used, activate it here)
# source venv/bin/activate

# Install project dependencies
pip3 install -r requirements.txt

# Run tests
# Ensure all tests are executed, even if some fail
set +e
python3 test.py --ci --git --buck2=/path/to/simulated/artifacts/buck2
set -e