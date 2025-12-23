#!/bin/bash

# Install project dependencies with increased memory for GWT
MAVEN_OPTS="-Xms3500m -Xmx3500m -Xss1024k" ./mvnw -B \
    -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn \
    -Dtoolchain.skip \
    -Denforcer.skip=true \
    -Dlicense.skip=true \
    -Dgwt.watchFileChanges=false \
    install -U -DskipTests=false -f pom.xml

# Run tests with all necessary flags and increased memory for GWT
MAVEN_OPTS="-Xms3500m -Xmx3500m -Xss1024k" ./mvnw -B -P!standard-with-extra-repos \
    -Dtoolchain.skip \
    -Denforcer.skip=true \
    -Dlicense.skip=true \
    -Dgwt.watchFileChanges=false \
    -Dgwt.logLevel=WARN \
    -Dgwt.strict=false \
    -Dgwt.compiler.skip=false \
    verify -U -Dmaven.javadoc.skip=true -Dsurefire.toolchain.version=17 -f pom.xml

# Print Surefire reports if tests fail
if [ $? -ne 0 ]; then
  find . -name "*.xml" -exec grep -l "failure" {} \; | while read file; do
    echo "Test failures in $file:"
    cat "$file"
  done
  exit 1
fi