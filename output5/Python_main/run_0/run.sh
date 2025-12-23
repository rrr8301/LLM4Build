#!/bin/bash

# run.sh

# Activate any virtual environments if needed (not applicable here)

# Install project dependencies
pip3 install --no-cache-dir -r requirements.txt

# Run tests
# Assuming tests are run using pytest or similar
pytest --maxfail=0 --continue-on-collection-errors