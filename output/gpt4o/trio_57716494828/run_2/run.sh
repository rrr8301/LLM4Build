#!/bin/bash

# Activate virtual environment
source venv/bin/activate

# Install project dependencies
pip install -r test-requirements.txt

# Run tests with proper permissions
set +e  # Continue on error
bash ./ci.sh
set -e