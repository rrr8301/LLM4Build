#!/bin/bash

# Activate any necessary environments (none in this case)

# Install project dependencies and build using Maven directly
mvn -V --file pom.xml --no-transfer-progress -DtrimStackTrace=false -P-use-toolchains,docker clean install

# Run tests
# Ensure all tests are executed, even if some fail
set +e
mvn test
set -e