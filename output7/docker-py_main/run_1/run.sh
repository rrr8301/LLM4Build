#!/bin/bash

# Step 1: Clone the repository using HTTPS
git clone https://github.com/docker/docker-py.git
cd docker-py

# Step 2: Set up the Python virtual environment
python3 -m venv venv
source venv/bin/activate

# Step 3: Install the project in development mode
python setup.py develop

# Step 4: Run the tests, ensuring all tests are executed
set +e  # Do not exit immediately on error
make test