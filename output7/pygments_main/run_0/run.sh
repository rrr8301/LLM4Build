#!/bin/bash

# Step 9: Activate envs
# Using python3-venv to create a virtual environment
python3 -m venv venv
source venv/bin/activate

# Step 9: Install project deps
pip install -e .
pip install -r requirements.txt

# Step 9: Run tests
# Ensure all tests are executed, even if some fail
set +e
tox -- -W error