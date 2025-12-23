#!/bin/bash

# Activate any necessary environments (none specified, so this is a placeholder)
# source /path/to/env/bin/activate

# Install project dependencies using getdeps.py
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive mvfst

# Build the mvfst project
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. mvfst --project-install-prefix mvfst:/usr/local

# Run tests
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. mvfst --project-install-prefix mvfst:/usr/local || true

# Ensure all tests are executed, even if some fail