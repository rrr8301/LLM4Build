#!/bin/bash

# Install project dependencies
./mvnw -B -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn -Dtoolchain.skip install -U -DskipTests=true -f pom.xml

# Run tests
./mvnw -B -P!standard-with-extra-repos -Dtoolchain.skip verify -U -Dmaven.javadoc.skip=true -Dsurefire.toolchain.version=17 -f pom.xml

# Print Surefire reports if tests fail
if [ $? -ne 0 ]; then
  ./util/print_surefire_reports.sh
fi