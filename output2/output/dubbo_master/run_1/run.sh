#!/bin/bash

# Activate any necessary environments (none in this case)

# Install project dependencies and run tests
# Ensure all tests are executed, even if some fail
set -e
./mvnw --batch-mode --no-snapshot-updates -e --no-transfer-progress clean test verify -Pjacoco,checkstyle -Dmaven.wagon.httpconnectionManager.ttlSeconds=120 -Dmaven.wagon.http.retryHandler.count=5 -DskipTests=false -DskipIntegrationTests=false -Dcheckstyle.skip=false -Dcheckstyle_unix.skip=false -Drat.skip=false -Dmaven.javadoc.skip=true || true

# Note: The '|| true' ensures that the script continues even if tests fail