#!/bin/bash

# Step 1: Activate the virtual environment
python3.8 -m venv venv
source venv/bin/activate

# Step 2: Install project dependencies
# Clone and install Click from source
git clone https://github.com/pallets/click.git
cd click
pip install -e .
cd ..

# Install testing dependencies
pip install tox

# Step 3: Ensure tox configuration is correct
# Check if a tox.ini or setup.cfg file exists and is properly configured
if [ ! -f tox.ini ] && [ ! -f setup.cfg ]; then
    echo "Error: No tox configuration file found (tox.ini or setup.cfg). Creating a default tox.ini."
    cat <<EOL > tox.ini
[tox]
envlist = py38

[testenv]
deps = pytest
commands = pytest
EOL
fi

# Step 4: Run the test suite using tox
# Ensure all tests are executed, even if some fail
set +e
tox