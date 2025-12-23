#!/bin/bash

# Activate the environment (if any)
# No specific virtual environment setup is mentioned, so we skip this step

# Install project dependencies
pip3 install -r requirements.txt || true

# Run tests
# Assuming a test command, replace with actual test command if known
pytest tests/ || true

# Ensure all tests are executed, even if some fail
set +e
pytest tests/