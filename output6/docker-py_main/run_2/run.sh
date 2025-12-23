#!/bin/bash

# Activate any necessary environments (none specified)

# Install project dependencies
python3 -m pip install --upgrade pip
pip3 install '.[ssh,dev]'

# Build the package
pip3 install build && python3 -m build .

# Run tests
set +e  # Continue on error
docker logout
rm -rf ~/.docker
pytest -v --cov=docker tests/unit
make integration-dind
make integration-dind-ssl
make integration-dind-ssh
set -e  # Stop on error