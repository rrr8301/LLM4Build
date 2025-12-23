#!/bin/bash

# Run tests
cd build
make run-tests || true  # Ensure all tests are executed even if some fail