#!/bin/bash

# run.sh

# Activate the virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Upgrade pip in the virtual environment
pip install --upgrade pip

# Install project dependencies
pip install -r requirements.txt

# Build the project
python setup.py build

# Run tests and ensure all tests are executed
pytest --cov=. --disable-warnings

# Placeholder for Codecov upload (manual step)
echo "Upload coverage to Codecov manually using the Codecov CLI or other means."