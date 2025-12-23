#!/bin/bash

# run.sh

# Activate the virtual environment
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests, ensuring all tests are executed even if some fail
pytest --continue-on-collection-errors --maxfail=0