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

# Ensure tox and uv are installed in the virtual environment
pip install tox uv

# Run tests using uv to handle the environment
set +e  # Continue on errors
uv run --locked tox -e py