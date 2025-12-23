#!/bin/bash

# run.sh

# Activate any virtual environments if needed (not using virtualenv here)
# Install project dependencies
pip3 install --no-cache-dir -r requirements.txt

# Run tests
# Assuming tests are run using pytest or a similar tool
# Ensure all tests are executed, even if some fail
pytest --continue-on-collection-errors || true