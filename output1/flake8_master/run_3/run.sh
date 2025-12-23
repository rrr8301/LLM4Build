#!/bin/bash

# Activate the virtual environment
python3.11 -m venv venv
source venv/bin/activate

# Upgrade pip and install project dependencies
pip install --upgrade setuptools pip
pip install tox

# Run tests with tox, ensuring all tests are executed
tox