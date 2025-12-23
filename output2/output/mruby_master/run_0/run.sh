#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# Example: source /path/to/venv/bin/activate

# Install project dependencies
bundle install

# Run tests
set +e  # Continue execution even if some tests fail
rake -m test:run:serial
set -e  # Re-enable exit on error