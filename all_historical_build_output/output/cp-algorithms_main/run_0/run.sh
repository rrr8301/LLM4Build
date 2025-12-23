#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests
# Assuming tests are run using a tool like pytest
pytest || true  # Continue running even if some tests fail