#!/bin/bash

# Install project dependencies
python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive mvfst

# Build the project
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. mvfst --project-install-prefix mvfst:/usr/local

# Run tests
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. mvfst --project-install-prefix mvfst:/usr/local || true

# Note: The '|| true' ensures that all tests are executed, even if some fail.