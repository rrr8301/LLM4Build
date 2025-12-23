#!/bin/bash

# Activate Python environment
python3.13 -m venv venv
source venv/bin/activate

# Check if requirements.txt exists before attempting to install
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
else
    echo "requirements.txt not found, skipping pip install"
fi

# Ensure tox is installed in the virtual environment
pip install tox

# Run tests
set +e  # Continue on errors
tox -e py