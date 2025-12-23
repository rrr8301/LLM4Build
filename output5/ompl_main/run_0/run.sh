#!/bin/bash

# Activate any necessary environments (none specified)

# Install project dependencies (if any)
# Assuming dependencies are already installed via Dockerfile

# Build the project
cd /app/build/Release
cmake ../..
make -j$(nproc)

# Optionally update Python bindings
make -j$(nproc) update_bindings || true

# Run tests
# Ensure all tests are executed, even if some fail
ctest --output-on-failure || true