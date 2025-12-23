#!/bin/bash

# Activate Python environment (if any virtual environment is used, activate it here)

# Install project dependencies
pip install -r /app/requirements.txt

# Build the project
python setup.py install

# Run tests
set +e  # Continue execution even if some tests fail
python test_age_py.py -db "postgres" -u "postgres" -pass "agens"
python test_networkx.py -db "postgres" -u "postgres" -pass "agens"
python -m unittest -v test_agtypes.py
set -e  # Re-enable exit on error