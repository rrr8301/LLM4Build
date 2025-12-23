#!/bin/bash

# run.sh

# Activate the virtual environment
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests
pytest tests/