#!/bin/bash

# Activate Python environment (if any)
# python3.12 -m venv venv
# source venv/bin/activate

# Install project dependencies (if any)
# pip install -r requirements.txt

# Print Maven version
./mvnw -version

# Run Maven tests
set +e  # Continue execution even if some tests fail
./mvnw -T 4C clean test -e -B -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn
set -e  # Stop execution on error for subsequent commands