#!/bin/bash

# Step 1: Clone the repository using HTTPS
cd /app
if [ ! -d "docker-py" ]; then
    git clone https://github.com/docker/docker-py.git
fi
cd docker-py

# Step 1.1: Checkout the correct branch or tag that contains setup.py
# Check if 'main' branch exists, otherwise fallback to 'master'
if git show-ref --verify --quiet refs/remotes/origin/main; then
    git checkout main
elif git show-ref --verify --quiet refs/remotes/origin/master; then
    git checkout master
else
    # Fallback to a specific tag or branch known to contain setup.py
    git fetch --all --tags
    git checkout tags/1.10.6  # Example tag, replace with the correct one if needed
fi

# Verify if setup.py exists, if not, try another branch or tag
if [ ! -f "setup.py" ]; then
    echo "setup.py not found in the current branch. Trying another branch or tag..."
    git fetch --all
    git checkout tags/1.10.6  # Replace with a known good tag or branch
fi

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
    dockerd --host=unix:///var/run/docker.sock --storage-driver=vfs &
    sleep 5  # Give it some time to start
fi

# Step 5: Run the tests, ensuring all tests are executed
set +e  # Do not exit immediately on error
make test