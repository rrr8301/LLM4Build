#!/bin/bash

set -e

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
if [ -f "/app/requirements.txt" ]; then
    pip install -r /app/requirements.txt
else
    echo "requirements.txt not found!"
    exit 1
fi

# Run tests
set +e
export OMP_NUM_THREADS=2
spin test -j3 -- --durations 10 --timeout=60
set -e