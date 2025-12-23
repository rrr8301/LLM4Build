#!/bin/bash

# Run tests
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. mvfst --project-install-prefix mvfst:/usr/local

# Ensure all test cases are executed, even if some fail
set +e
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. mvfst --project-install-prefix mvfst:/usr/local
set -e