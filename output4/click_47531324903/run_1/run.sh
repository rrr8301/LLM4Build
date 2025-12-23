#!/bin/bash

# Activate Python environment
python3.13 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests
set +e  # Continue on errors
tox -e py3.13