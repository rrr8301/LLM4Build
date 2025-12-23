#!/bin/bash

# Create and activate the Python virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Upgrade pip and install setuptools and distutils in the virtual environment
pip install --upgrade pip setuptools distutils

# Install project dependencies
pip install -r requirements.txt

# Run tests with nox
LIBSODIUM_MAKE_ARGS="-j$(nproc)" nox -s tests

# Exit with the status of the last command
exit $?