#!/bin/bash

# Create and activate the virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Upgrade pip and install required Python packages within the virtual environment
pip install --upgrade pip setuptools tox virtualenv

# Install project dependencies
pip install -r requirements.txt  # Assuming you have a requirements.txt file

# Run tests using tox
tox -e py  # Ensure all tests run