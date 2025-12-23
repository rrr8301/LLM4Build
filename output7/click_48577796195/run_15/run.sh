#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# For PyPy, no virtual environment activation is needed as we are using the system installation

# Install project dependencies
if [ -f /app/requirements.txt ]; then
    pypy3 -m pip install --no-cache-dir -r /app/requirements.txt
else
    echo "requirements.txt not found!"
    exit 1
fi

# Run tests
if command -v tox &> /dev/null; then
    tox -e pypy
else
    echo "tox command not found!"
    exit 1
fi