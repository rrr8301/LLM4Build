#!/bin/bash

# Step 1: Clone the repository using HTTPS
cd /app
if [ ! -d "docker-py" ]; then
    git clone https://github.com/docker/docker-py.git
fi
cd docker-py

# Step 1.1: Checkout a specific branch or tag that contains setup.py
git checkout master  # Replace 'master' with the correct branch or tag if needed

# Step 2: Set up the Python virtual environment
python3 -m venv venv
source venv/bin/activate

# Step 3: Install the project in development mode
if [ -f "setup.py" ]; then
    python setup.py develop
else
    echo "Error: setup.py not found!"
    exit 1
fi

# Step 4: Ensure Docker daemon is running
if ! pgrep -x "dockerd" > /dev/null; then
    echo "Starting Docker daemon..."
    dockerd &
    sleep 5  # Give it some time to start
fi

# Step 5: Run the tests, ensuring all tests are executed
set +e  # Do not exit immediately on error
make test