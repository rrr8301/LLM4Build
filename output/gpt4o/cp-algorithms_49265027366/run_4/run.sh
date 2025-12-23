#!/bin/bash

# Activate Python virtual environment
source /opt/venv/bin/activate

# Install project dependencies (in case any were added after image build)
pip install -r preview/requirements.txt

# Run tests
set +e  # Continue execution even if some tests fail
cd test
./test.sh