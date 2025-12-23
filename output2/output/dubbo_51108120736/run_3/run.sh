#!/bin/bash

# Fail script on any error
set -e

# Set environment variables
export FORK_COUNT=2
export FAIL_FAST=0
export SHOW_ERROR_DETAIL=1
export VERSIONS_LIMIT=4
export JACOCO_ENABLE=true
export CANDIDATE_VERSIONS='spring.version:5.3.24,6.1.5; spring-boot.version:2.7.6,3.2.3;'
export MAVEN_OPTS="-XX:+UseG1GC -XX:InitiatingHeapOccupancyPercent=45 -XX:+UseStringDeduplication -XX:-TieredCompilation -XX:TieredStopAtLevel=1 -Dmaven.javadoc.skip=true -Dmaven.wagon.http.retryHandler.count=5 -Dmaven.wagon.httpconnectionManager.ttlSeconds=120"
export MAVEN_ARGS="-e --batch-mode --no-snapshot-updates --no-transfer-progress --fail-fast"

# Run Maven tests
set +e
./mvnw $MAVEN_ARGS clean test verify -Pjacoco,jdk15ge-simple,'!jdk15ge-add-open',skip-spotless -DtrimStackTrace=false -Dmaven.test.skip=false -Dcheckstyle.skip=false -Dcheckstyle_unix.skip=false -Drat.skip=false -DembeddedZookeeperPath=/app/.tmp/zookeeper 2>&1 | tee >(grep -n -B 1 -A 200 "FAILURE! -- in" > test_errors.log)
TEST_EXIT_CODE=$?
set -e

# Print test error log if tests fail
if [ $TEST_EXIT_CODE -ne 0 ]; then
    cat test_errors.log
fi

# Exit with the test exit code
exit $TEST_EXIT_CODE