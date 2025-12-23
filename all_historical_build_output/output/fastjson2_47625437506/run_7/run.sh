#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate environment variables
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Duser.timezone=Asia/Shanghai"

# Ensure Maven wrapper is executable if it exists
if [ -f "./mvnw" ]; then
    echo "Using Maven Wrapper"
    chmod +x ./mvnw
    ./mvnw -V --no-transfer-progress -Pgen-javadoc -Pgen-dokka clean package
else
    echo "Using System Maven"
    mvn -V --no-transfer-progress -Pgen-javadoc -Pgen-dokka clean package
fi

# Run tests
echo "Running tests"
mvn test