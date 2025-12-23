#!/bin/bash

# Activate Nix environment
source /root/.nix-profile/etc/profile.d/nix.sh

# Build the CLI
nix develop -L --no-update-lock-file --extra-experimental-features nix-command flakes --command just build-cli

# Run CLI Unit Tests
nix develop -L --no-update-lock-file --extra-experimental-features nix-command flakes --command just impure-tests

# Run CLI Integration Tests
mkdir -p ./test-results
nix develop -L --no-update-lock-file --extra-experimental-features nix-command flakes --command just integ-tests -- \
  --filter-tags '"!activate,!containerize,!catalog"' \
  --report-formatter junit \
  --output $PWD/test-results

# Capture process tree for failing tests
if [ $? -ne 0 ]; then
  nix develop -L --no-update-lock-file --extra-experimental-features nix-command flakes --command pstree
fi