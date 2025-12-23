#!/bin/bash

# Start gnome-keyring daemon for secret service
gnome-keyring-daemon --components=secrets --daemonize --unlock <<< 'foobar'

# Install Python versions via uv
uv python install

# Run cargo tests with specified features
# Using --no-fail-fast to ensure all tests run even if some fail
cargo nextest run \
    --features python-patch,native-auth,secret-service \
    --workspace \
    --status-level skip \
    --failure-output immediate-final \
    --no-fail-fast \
    -j 20 \
    --final-status-level slow

# Exit with success status regardless of test results
# (We want the container to complete even if tests fail)
exit 0