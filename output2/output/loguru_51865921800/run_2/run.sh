# run.sh
#!/bin/bash

# Create a virtual environment
pypy3 -m venv /app/venv

# Activate the virtual environment
source /app/venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install tox

# Run tests
# Ensure all tests are executed, even if some fail
tox -e tests || true