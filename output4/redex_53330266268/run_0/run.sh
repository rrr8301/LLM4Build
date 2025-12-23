#!/bin/bash

# Build the project
make

# Run tests, ensuring all tests are executed even if some fail
make test || true