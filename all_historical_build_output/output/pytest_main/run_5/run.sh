#!/bin/bash

# Install project dependencies if requirements.txt is present
if [ -f requirements.txt ]; then
    pip3 install -r requirements.txt
fi

# Run tests with pytest
pytest --continue-on-collection-errors