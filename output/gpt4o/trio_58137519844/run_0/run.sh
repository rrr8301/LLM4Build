#!/bin/bash

# Activate virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r test-requirements.txt

# Run tests
set +e  # Continue on error
./ci.sh
set -e  # Stop on error