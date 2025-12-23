#!/bin/bash

# Activate Python virtual environment
source venv/bin/activate

# Install project dependencies (redundant if already installed in Dockerfile, but kept for safety)
pip install -r preview/requirements.txt

# Run tests
set +e  # Continue execution even if some tests fail
./test/test.sh