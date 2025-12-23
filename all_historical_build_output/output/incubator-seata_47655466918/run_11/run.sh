#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Print Maven version
mvn -version

# Run Maven tests
# Ensure all tests are executed, even if some fail
set +e
mvn -T 4C clean test -e -B -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn \
    -Denforcer.skip=true -Dlicense.skip=true
TEST_EXIT_CODE=$?
set -e

# Display test results for debugging
echo "Displaying test results for debugging:"
if [ -d "/app/config/seata-config-nacos/target/surefire-reports" ]; then
    cat /app/config/seata-config-nacos/target/surefire-reports/*.txt
else
    echo "Test report directory not found!"
fi

# Exit with the test exit code
exit $TEST_EXIT_CODE