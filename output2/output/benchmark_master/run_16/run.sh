#!/bin/bash

# Install project dependencies
if [ -f "tools/requirements.txt" ]; then
    python3.12 -m pip install -r tools/requirements.txt
else
    echo "Error: tools/requirements.txt not found."
    exit 1
fi

# Check if pyproject.toml exists and update license format if necessary
if [ -f "pyproject.toml" ]; then
    sed -i 's/project.license = {.*}/project.license = "Apache-2.0"/' pyproject.toml
    sed -i 's/License :: OSI Approved :: Apache Software License/License :: OSI Approved :: Apache-2.0 License/' pyproject.toml
fi

# Ensure MODULE.bazel exists
if [ ! -f "MODULE.bazel" ]; then
    echo "Error: MODULE.bazel not found. Please ensure all necessary Bazel files are present."
    exit 1
fi

# Build the project
python3.12 -m build

# Run tests
if [ -d "tests" ]; then
    python3.12 -m unittest discover -s tests
else
    echo "Error: tests directory not found."
    exit 1
fi

# Exit with the status of the tests
exit $?