#!/bin/bash

# Install project dependencies
python3.12 -m pip install -r tools/requirements.txt

# Build the project
python3.12 -m build

# Run tests
python3.12 -m unittest discover

# Exit with the status of the tests
exit $?