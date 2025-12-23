#!/bin/bash

# Activate Python environment (if any virtual environment is used, activate it here)

# Install project dependencies
pip install -r requirements.txt

# Run tests with tox, ensuring all tests are executed
tox -- -W error || true