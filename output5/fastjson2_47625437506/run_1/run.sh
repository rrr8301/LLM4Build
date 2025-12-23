#!/bin/bash

# Activate environment variables
export JAVA_HOME=/usr/lib/jvm/zulu-21-amd64
export PATH="$JAVA_HOME/bin:$PATH"
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Duser.timezone=Asia/Shanghai"

# Install project dependencies and run tests
./mvnw -V --no-transfer-progress -Pgen-javadoc -Pgen-dokka clean package

# Ensure all tests are executed, even if some fail
set +e
./mvnw test
set -e