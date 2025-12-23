#!/bin/bash

# Activate the virtual environment
source /app/venv/bin/activate

# Install project dependencies
pip install --no-cache-dir -r /app/requirements.txt

# Run tests and ensure all tests are executed
pytest --junitxml=results.xml --cov=. || true

# Note: Uploading artifacts is ignored as it is GitHub-specific