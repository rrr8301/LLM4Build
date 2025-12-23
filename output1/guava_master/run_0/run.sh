#!/bin/bash

# Fail on any error
set -e

# Print commands as they run
set -x

# Install project dependencies
./mvnw -B -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn -Dtoolchain.skip install -U -DskipTests=true -f pom.xml

# Run tests (continue on failure to ensure all tests run)
set +e
./mvnw -B -P!standard-with-extra-repos -Dtoolchain.skip verify -U -Dmaven.javadoc.skip=true -Dsurefire.toolchain.version=17 -f pom.xml
test_exit_code=$?

# Print Surefire reports if tests failed
if [ $test_exit_code -ne 0 ]; then
    echo "Tests failed - printing Surefire reports"
    ./util/print_surefire_reports.sh
fi

# Exit with the test exit code
exit $test_exit_code