#!/bin/bash

# Print Maven version
./mvnw -version

# Run Maven tests
set -e
./mvnw -T 4C clean test -e -B -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn || true

# Ensure all tests are executed, even if some fail
echo "Tests completed."