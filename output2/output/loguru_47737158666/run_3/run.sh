#!/bin/bash

# Install project dependencies
python3.10 -m pip install --upgrade pip
python3.10 -m pip install tox

# Run tests
tox -e tests