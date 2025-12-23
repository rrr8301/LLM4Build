#!/bin/bash

# Activate Python environment (if any specific activation is needed, otherwise skip)
# source /path/to/venv/bin/activate

# Install project dependencies
pip3 install -r preview/requirements.txt

# Run tests
set +e  # Continue execution even if some tests fail
./test/test.sh