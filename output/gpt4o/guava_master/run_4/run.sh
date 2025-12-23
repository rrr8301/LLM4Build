#!/bin/bash

# Install project dependencies
./mvnw -B -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn \
    -Dtoolchain.skip \
    -Denforcer.skip=true \
    -Dlicense.skip=true \
    install -U -DskipTests=false -f pom.xml

# Run tests with all necessary flags
./mvnw -B -P!standard-with-extra-repos \
    -Dtoolchain.skip \
    -Denforcer.skip=true \
    -Dlicense.skip=true \
    verify -U -Dmaven.javadoc.skip=true -Dsurefire.toolchain.version=17 -f pom.xml

# Print Surefire reports if tests fail
if [ $? -ne 0 ]; then
  find . -name "*.xml" -exec grep -l "failure" {} \; | while read file; do
    echo "Test failures in $file:"
    cat "$file"
  done
  exit 1
fi