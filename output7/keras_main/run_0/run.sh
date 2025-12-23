#!/bin/bash

# Step 9: Activate envs
# Create a virtual environment
python3 -m venv venv
source venv/bin/activate

# Step 9: Install project deps
pip install --no-cache-dir -r requirements.txt
python pip_build.py --install

# Step 9: Run tests
# Ensure all tests are executed, even if some fail
pytest keras || true