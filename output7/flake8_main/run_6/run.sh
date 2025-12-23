#!/bin/bash

# Activate the virtual environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --no-cache-dir -r requirements.txt

# Run tests
# Assuming pytest is used for testing; replace with the actual test command if different
pytest --continue-on-collection-errors  # Ensure all tests run even if some fail

# Deactivate the virtual environment
deactivate