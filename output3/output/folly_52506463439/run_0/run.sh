#!/bin/bash

# Activate environment (if any)

# Install project dependencies
python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive folly

# Build the project
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. folly --project-install-prefix folly:/usr/local

# Run tests
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local

# Ensure all tests are executed, even if some fail
set +e
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local
set -e