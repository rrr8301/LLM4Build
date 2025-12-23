#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Python virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Install Python dependencies if any (placeholder)
# pip install -r requirements.txt

# Print Maven version
mvn -version

# Run Maven tests
# Ensure all tests are executed, even if some fail
set +e
mvn -T 4C clean test -e -B -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn
TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE