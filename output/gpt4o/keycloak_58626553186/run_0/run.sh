#!/bin/bash

# Activate environment variables
export MAVEN_ARGS="-B -nsu -Daether.connector.http.connectionMaxTtl=25"
export SUREFIRE_RERUN_FAILING_COUNT=2
export SUREFIRE_RETRY="-Dsurefire.rerunFailingTestsCount=2"

# Install project dependencies
./mvnw install -e -pl testsuite/integration-arquillian/servers/auth-server/quarkus

# Run new base tests
./mvnw package -f tests/pom.xml -Dtest=JDKTestSuite

# Run base tests
TESTS=$(testsuite/integration-arquillian/tests/base/testsuites/suite.sh jdk)
echo "Tests: $TESTS"
./mvnw test $SUREFIRE_RETRY -Pauth-server-quarkus -Dtest=$TESTS "-Dwebdriver.chrome.driver=$CHROMEWEBDRIVER/chromedriver" -pl testsuite/integration-arquillian/tests/base 2>&1 | misc/log/trimmer.sh

# Build with JDK
./mvnw install -e -DskipTests -DskipExamples -DskipProtoLock=true

# Run unit tests
./mvnw test -pl "$(.github/scripts/find-modules-with-unit-tests.sh)"

# Ensure all tests are executed
exit 0