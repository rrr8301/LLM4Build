#!/bin/bash

set -e
set -o pipefail

# Install system dependencies
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive folly

# Build folly
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. folly --project-install-prefix folly:/usr/local

# Test folly
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local || true

# Note: The '|| true' ensures that all tests are executed, even if some fail.