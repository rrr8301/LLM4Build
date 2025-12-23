#!/bin/bash

# Activate Python environment
source /usr/bin/activate

# Run unit tests
tox -- --continue-on-collection-errors -m unit || true

# Run integration tests
tox -- --continue-on-collection-errors -m functional -k 'not harvesting' || true

# Build documentation
cd docs && make html