#!/bin/bash

# Activate Python environment (if any virtual environment is used)
# source /path/to/venv/bin/activate

# Install project dependencies
python3.12 -m pip install -r requirements/build_requirements.txt
python3.12 -m pip install -r requirements/test_requirements.txt

# Build the project
spin build -- --werror -Dallow-noblas=false

# Run tests, ensuring all tests are executed
set +e  # Do not exit immediately on error
spin test -- --timeout=600 --durations=10
set -e  # Re-enable exit on error