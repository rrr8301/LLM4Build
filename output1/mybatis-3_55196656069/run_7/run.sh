#!/bin/bash

# Ensure JAVA_HOME is set correctly
export JAVA_HOME=/usr/lib/jvm/jdk-21
export PATH="$JAVA_HOME/bin:$PATH"

# Activate environment variables
export TEST_CONTAINERS_PROFILE="-PtestContainers"

# Install project dependencies
mvn install -Denforcer.skip=true -Dlicense.skip=true

# Run tests
mvn test -B -V --no-transfer-progress -Dlicense.skip=true $TEST_CONTAINERS_PROFILE