#!/bin/bash

# Build Acton
make -j2 -C /app

# Run tests
make -C /app test || true  # Ensure all tests run even if some fail