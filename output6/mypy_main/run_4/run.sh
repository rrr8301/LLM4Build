#!/bin/bash

# Activate virtual environment
source venv/bin/activate

# Setup tox environment
tox --notest

# Run tests
set +e  # Continue execution even if some tests fail
tox