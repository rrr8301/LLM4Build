#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise this is a placeholder)

# Install project dependencies and run tests
set -e
mvn --batch-mode --no-transfer-progress verify javadoc:jar || true
mvn test --batch-mode --no-transfer-progress --activate-profiles native-image-test --projects test-graal-native-image --also-make || true
mvn artifact:check-buildplan --batch-mode --no-transfer-progress || true
mvn clean install --batch-mode --no-transfer-progress -Dproguard.skip -DskipTests || true
mvn clean verify artifact:compare --batch-mode --no-transfer-progress -Dproguard.skip -DskipTests -Dbuildinfo.attach=false || true

# Ensure all test cases are executed, even if some fail