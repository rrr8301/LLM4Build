#!/bin/bash

# Activate the virtual environment
source /venv/bin/activate

# Install project dependencies (in case requirements changed)
pip install -r requirements.txt

# Run tests
# Ensure all tests are executed, even if some fail
set +e
python test.py --ci --git --buck2=/path/to/simulated/artifacts/buck2
EXIT_CODE=$?
set -e

exit $EXIT_CODE