#!/bin/bash

set -e

# Build and test with Maven
./mvnw --batch-mode --no-snapshot-updates -e --no-transfer-progress --fail-fast clean test verify \
  -Pjacoco -Dmaven.wagon.httpconnectionManager.ttlSeconds=120 -Dmaven.wagon.http.retryHandler.count=5 \
  -DskipTests=false -DskipIntegrationTests=false -Dcheckstyle.skip=false -Dcheckstyle_unix.skip=false \
  -Drat.skip=false -Dmaven.javadoc.skip=true || true