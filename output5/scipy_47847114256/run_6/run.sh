#!/bin/bash

set -e
set -o pipefail

# Activate Python virtual environment
source /app/venv/bin/activate

# Install project dependencies
if [ -f /app/requirements.txt ]; then
    pip install -r /app/requirements.txt
else
    echo "requirements.txt not found, skipping dependency installation."
fi

# Run tests
set +e
spin test -j3 -- --durations 10 --timeout=60
set -e