#!/bin/bash

# Build the project
python3.11 setup.py build

# Run tests and ensure all tests are executed
pytest --continue-on-collection-errors