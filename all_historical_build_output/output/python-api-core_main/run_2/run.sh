#!/bin/bash

# run.sh

# Install project dependencies
pip3 install --no-cache-dir -r requirements.txt

# Run tests
# Assuming tests are run using pytest or a similar tool
# Ensure all tests are executed
pytest --continue-on-collection-errors