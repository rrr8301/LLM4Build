#!/bin/bash

# Activate virtual environment
source venv/bin/activate

# Install project dependencies
pip install -r test-requirements.txt

# Run tests
set +e  # Continue on error
./ci.sh
set -e