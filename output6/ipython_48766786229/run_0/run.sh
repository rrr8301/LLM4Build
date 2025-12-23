#!/bin/bash

# Activate environment (if any virtual environment is used, otherwise skip)
# source /path/to/venv/bin/activate

# Install project dependencies
python3.13 -m pip install --no-binary curio --upgrade -e .[test_extra]

# Run tests
pytest --color=yes -raXxs --cov --cov-report=xml --maxfail=15 || true

# Note: Coverage upload to Codecov is not handled in this script.