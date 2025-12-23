#!/bin/bash

# Install project dependencies
python3.12 -m pip install --no-cache-dir -r requirements.txt

# Run tests and ensure all tests are executed
pytest --junitxml=results.xml --cov=. || true

# Note: Uploading artifacts is ignored as it is GitHub-specific