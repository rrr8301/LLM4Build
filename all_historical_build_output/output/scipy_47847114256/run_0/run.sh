#!/bin/bash

set -e

# Activate Python 3.11 environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Run tests
set +e
export OMP_NUM_THREADS=2
spin test -j3 -- --durations 10 --timeout=60
set -e