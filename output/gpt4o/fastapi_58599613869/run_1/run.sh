#!/bin/bash

# Activate virtual environment
source /app/venv/bin/activate

# Run tests
set +e  # Continue execution even if some tests fail
bash scripts/test.sh