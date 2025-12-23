#!/bin/bash

# Install project dependencies
if [ -f "tools/requirements.txt" ]; then
    python3.12 -m pip install -r tools/requirements.txt
else
    echo "Error: tools/requirements.txt not found."
    exit 1
fi

# Build the project
python3.12 -m build

# Run tests
python3.12 -m unittest discover

# Exit with the status of the tests
exit $?