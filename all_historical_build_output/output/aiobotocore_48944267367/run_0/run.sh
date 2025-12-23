#!/bin/bash

# run.sh

# Activate the virtual environment
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests
set +e  # Continue on error
pytest tests/ || true