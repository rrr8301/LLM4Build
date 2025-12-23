#!/bin/bash

# Install project dependencies
pip3 install -r requirements.txt || true

# Run tests with pytest, continue even if some tests fail
pytest --continue-on-collection-errors || true