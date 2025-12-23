#!/bin/bash

# Activate any virtual environments if necessary (not used here)

# Install project dependencies
pip3 install -r requirements.txt || true

# Run tests with pytest
pytest || true

# Ensure all tests are executed, even if some fail
pytest --continue-on-collection-errors