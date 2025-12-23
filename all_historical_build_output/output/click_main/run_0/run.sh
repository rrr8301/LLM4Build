#!/bin/bash

# Step 1: Activate the virtual environment
python3 -m venv venv
source venv/bin/activate

# Step 2: Install project dependencies
# Clone and install Click from source
git clone https://github.com/pallets/click.git
cd click
pip install -e .
cd ..

# Install testing dependencies
pip install tox

# Step 3: Run the test suite using tox
# Ensure all tests are executed, even if some fail
set +e
tox