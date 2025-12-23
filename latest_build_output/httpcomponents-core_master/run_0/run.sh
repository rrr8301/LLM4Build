#!/bin/bash

# Activate any necessary environments (none in this case)

# Install project dependencies and build
./mvnw -V --file pom.xml --no-transfer-progress -DtrimStackTrace=false -P-use-toolchains,docker

# Run tests
# Ensure all tests are executed, even if some fail
set +e
mvn test
set -e