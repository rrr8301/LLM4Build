#!/bin/bash

# Activate Nix environment
source /root/.nix-profile/etc/profile.d/nix.sh

# Build the CLI
nix develop -L --no-update-lock-file --command just build-cli

# Run CLI Unit Tests
nix develop -L --no-update-lock-file --command just impure-tests || true

# Run CLI Integration Tests
mkdir -p ./test-results
nix develop -L --no-update-lock-file --command just integ-tests -- \
  --filter-tags '"!activate,!containerize,!catalog"' \
  --report-formatter junit \
  --output $PWD/test-results || true

# Capture process tree for failing tests
if [ $? -ne 0 ]; then
  nix develop -L --no-update-lock-file --command pstree
fi